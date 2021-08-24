//
//  ViewController.swift
//  FoursquareCloneApp
//
//  Created by Semih Kalaycı on 24.08.2021.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
         //Veri kaydetme --------------------------------------------------------------------------------
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Banana"
        parseObject["calories"] = 150
        parseObject.saveInBackground { success, error in//saveInBackground o an bağlantı varsa kaydet saveEventually eninde sonunda yani bağlantı şuan yoksa da ilk bulduğunda kaydet
            
            if error != nil {
                print(error?.localizedDescription)
                
            }else{
                print("uploaded")
            }
            
        }//----------------------------------------------------------------------------------------------
         */
        /*
         //veri çekme -----------------------------------------------------------------------------------
        let query = PFQuery(className: "Fruits")
        //query.whereKey("name", contains: "Apple") //adı Apple olanı getir
        //query.whereKey("calories", greaterThan: 120) //calories 120 den bütük olanları getir
        query.findObjectsInBackground { objects, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                print(objects)
                
            }
            
        }//----------------------------------------------------------------------------------------------
         
         */
        
        
    }


}

