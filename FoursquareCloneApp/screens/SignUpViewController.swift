//
//  SignUpViewController.swift
//  FoursquareCloneApp
//
//  Created by Semih Kalaycı on 24.08.2021.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var errorL: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegisterBtnClicked(_ sender: Any) {
        
        
        if nameTF.text != "" {
            
            if surnameTF.text != ""{
                if emailTF.text != ""{
                    if passwordTF.text != ""{
                        if confirmPasswordTF.text != ""{
                            
                            if passwordTF.text == confirmPasswordTF.text {
                                
                                // saving process
                                
                                let parseObject = PFObject(className: "Users")
                                parseObject["name"] = nameTF.text
                                parseObject["surname"] = surnameTF.text
                                parseObject["password"] = passwordTF.text
                                parseObject.saveInBackground { success, error in
                                    if success {
                                        self.performSegue(withIdentifier: "LoginScreenVC", sender: nil)
                                        print("success saved")
                                    }else{
                                        self.errorL.text = error?.localizedDescription
                                    }
                                }
                                
                                
                            }else{
                                errorL.text = "Password did not match!"
                            }
                        }else{
                            errorL.text = "Confirm Password can not be empty!"
                        }
                    }else{
                        errorL.text = "Password can not be empty!"
                    }

                    
                }else{
                    errorL.text = "Email can not be empty!"
                }
            }else{
                errorL.text = "Surname can not be empty!"
            }
        }else{
            
            errorL.text = "Name can not be empty!"
        }
        
        

        
        
        
    }
    
    

   

}
