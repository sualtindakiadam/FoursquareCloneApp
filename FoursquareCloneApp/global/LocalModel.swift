//
//  LocalModel.swift
//  FoursquareCloneApp
//
//  Created by Semih Kalaycı on 25.08.2021.
//

import Foundation
import UIKit

class LocalModel {
    static let sharedInstance = LocalModel()
    var  placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var lat = ""
    var long = ""
    
    private init(){}
    
}
