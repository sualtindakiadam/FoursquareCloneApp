//
//  DetailLocationViewController.swift
//  FoursquareCloneApp
//
//  Created by Semih Kalaycı on 24.08.2021.
//

import UIKit
/*
 // bu şekilde tanımlayıp her yerden direkt olarak çağırılabilir fakat özellikle büyük projeler için güvenli değildir tavsiye edilmez
var globalPlaceName = ""
var globalPlaceType = ""
var globalPlaceAtmosphere = ""
*/
class DetaiAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeNameTF: UITextField!
    @IBOutlet weak var placeTypeTF: UITextField!
    @IBOutlet weak var placeAtmosphereTF: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        placeImageView.isUserInteractionEnabled = true // görsele tıklanabilir
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage)) // birşeye tıklanabilir mi tıklanırsa ne olur
        placeImageView.addGestureRecognizer(gestureRecognizer) //resmin tıklanılabilirliğini atadık
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        
        if placeNameTF.text != "" && placeTypeTF.text != "" && placeAtmosphereTF.text != ""{
            
            if let choosenImage = placeImageView.image {
                LocalModel.sharedInstance.placeName = placeNameTF.text!
                LocalModel.sharedInstance.placeAtmosphere = placeAtmosphereTF.text!
                LocalModel.sharedInstance.placeType = placeTypeTF.text!
                LocalModel.sharedInstance.placeImage = choosenImage
                
            }
            performSegue(withIdentifier: "MapPageVC", sender: nil)
            
        }else{
            let alert = UIAlertController(title: "Alert", message: "Boş girilemez", preferredStyle: UIAlertController.Style.alert)
            let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okBtn)
            present(alert, animated: true, completion: nil)
        }
        
        
        
        
    }
    
    @objc func chooseImage (){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {//görsel seçildikten sonra ne olacak
        placeImageView.image = info[.originalImage] as? UIImage // resmi image a ata
        self.dismiss(animated: true, completion: nil)//seçme ekranını kapat
    }
    


}
