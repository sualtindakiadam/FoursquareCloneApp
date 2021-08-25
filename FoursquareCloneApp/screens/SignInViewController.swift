//
//  ViewController.swift
//  FoursquareCloneApp
//
//  Created by Semih Kalaycı on 24.08.2021.
//

import UIKit
import Parse

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorL: UILabel!
    

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
    
    @IBAction func SignInBtnClicked(_ sender: Any) {
        
        if emailTF.text != ""{
            if passwordTF.text != ""{
                /*
                // kendi login yöntemim
                let query = PFQuery(className: "Users")
                query.whereKey("email", contains: emailTF.text).whereKey("password", contains: passwordTF.text)
                query.findObjectsInBackground { object, error in
                    if object != [] && error == nil{
                        self.errorL.text = ""
                        print("success login")
                        self.performSegue(withIdentifier: "AppNavigationControl", sender: nil)
                        
                    }else{
                        print("error \(error) ----- object \(object)")
                        self.errorL.text = "Sorry, your email or password was incorrect."
                    }
                }*/
                
                // parse login yöntemi----------------------------------------------------------------------------------------
                PFUser.logInWithUsername(inBackground: emailTF.text!, password: passwordTF.text!) { user, error in
                    if error != nil {
                        self.errorL.text = "şifre hatalı"
                    }else{
                        print("----------------------------------")
                        print(user)
                        self.performSegue(withIdentifier: "AppNavigationControl", sender: nil)
                    }
                    
                }
                //-----------------------------------------------------------------------------------------------------------
                
            }else{
                errorL.text = "Password can not be empty!"
            }
            
        }else{
            errorL.text = "Email can not be empty!"
            
        }
        
        
        
        
    }
    

}

