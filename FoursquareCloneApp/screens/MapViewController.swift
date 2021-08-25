//
//  MapViewController.swift
//  FoursquareCloneApp
//
//  Created by Semih Kalaycı on 25.08.2021.
//

import UIKit
import MapKit
import Parse

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!

    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveBtnClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBtnClicked))
        
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(recognizer)
        
        
    }
    
    @objc func chooseLocation(gestureRecognizer : UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizer.State.began{ // birir burayı tıklamayı başlattıysa
            
            let touches = gestureRecognizer.location(in: self.mapView) // mapview objesi sınırları üzerinde tıklanılan noktayı al
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView) // tıklanılan noktayı kordinata çevirmel
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = LocalModel.sharedInstance.placeName
            annotation.subtitle = LocalModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(annotation)
            LocalModel.sharedInstance.lat = String(coordinates.latitude)
            LocalModel.sharedInstance.long = String(coordinates.longitude)
            
            
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {//kullanıcının konumu update olunca
        locationManager.stopUpdatingLocation()// lokasyonu almayı durdurur
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func saveBtnClicked (){
        //parse
        
        let object = PFObject(className: "Places")
        object["name"] = LocalModel.sharedInstance.placeName
        object["type"] = LocalModel.sharedInstance.placeType
        object["atmosphere"] = LocalModel.sharedInstance.placeAtmosphere
        object["lat"] =  LocalModel.sharedInstance.lat
        object["long"] =  LocalModel.sharedInstance.long
        
        if let imageData = LocalModel.sharedInstance.placeImage.jpegData(compressionQuality: 0.5){
            object["image"] = PFFileObject(name: "image.jpeg", data: imageData)
        }
        
        object.saveInBackground { success, error in
            
            if !success || error != nil {
                
                let alert = UIAlertController(title: "Alert", message: "Hata var", preferredStyle: UIAlertController.Style.alert)
                let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okBtn)
                self.present(alert, animated: true, completion: nil)
                
                
            }else{
                self.performSegue(withIdentifier: "saveDoneGoHome", sender: nil)
            }
            
        }
        
        
    }
    @objc func backBtnClicked (){
        self.dismiss(animated: true, completion: nil)
        
    }
    



}
