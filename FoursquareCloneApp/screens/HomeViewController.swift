//
//  HomeViewController.swift
//  FoursquareCloneApp
//
//  Created by Semih Kalaycı on 24.08.2021.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNewLocation))
    }
    
    @objc func addNewLocation(){
        
        print("added")
        
    }



}
