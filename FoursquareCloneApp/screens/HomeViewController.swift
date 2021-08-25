//
//  HomeViewController.swift
//  FoursquareCloneApp
//
//  Created by Semih Kalaycı on 24.08.2021.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var placeNameArray = [String]()
    var placeIdArray = [String]()
    var selectedPlaceID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNewLocation))
        navigationController?.navigationBar.topItem?.leftBarButtonItem=UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logout))
        
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromParse()
    }
    
    func getDataFromParse(){
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                self.makeAlert(title: "error", message: error?.localizedDescription ?? "error")

            }else{
                
                if objects != nil {
                    self.placeNameArray.removeAll(keepingCapacity: false)
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String{
                            if let placeId = object.objectId {
                                self.placeNameArray.append(placeName)
                                self.placeIdArray.append(placeId)
                            }
                        }
                        
                    }
                    
                }
                self.tableView.reloadData()
                
            }
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeIdArray.count
    }
    
    @objc func addNewLocation(){
        
        self.performSegue(withIdentifier: "DetailAddPageVC", sender: nil)
        
    }
    
    @objc func logout(){
        
        PFUser.logOutInBackground { error in
            if error != nil {
                self.makeAlert(title: "error", message: error?.localizedDescription ?? "error")
            }else{
                self.performSegue(withIdentifier: "LogoutVC", sender: nil)
            }
        }
        
    }
    
    func  makeAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //segue olmadan önce ne yapacak
        if segue.identifier == "DetailsPageVC"{
            let detailVC = segue.destination as! DetailViewController
            detailVC.choosenPlaceId = selectedPlaceID
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//bir row a tıklşandığında ne yapılacak
        selectedPlaceID = placeIdArray[indexPath.row]
        self.performSegue(withIdentifier: "DetailsPageVC", sender: nil)
    }



}
