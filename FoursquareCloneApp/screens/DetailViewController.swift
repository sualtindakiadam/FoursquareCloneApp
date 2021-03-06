//
//  DetailViewController.swift
//  FoursquareCloneApp
//
//  Created by Semih Kalaycı on 25.08.2021.
//

import UIKit
import MapKit
import Parse

class DetailViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsNameL: UILabel!
    @IBOutlet weak var detailTypeL: UILabel!
    @IBOutlet weak var detailsAtmosphereL: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    
    
    var choosenPlaceId = ""
    var  chosenLat = Double()
    var chosenLong = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(choosenPlaceId)
        
        detailsMapView.delegate = self
        
        getDataFromParse()
        
    }
    
    func getDataFromParse(){
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", contains: choosenPlaceId)
        query.findObjectsInBackground { object, error in
            
            
            if error != nil {
                
            }else{
                //objects
                if object != nil {
                    self.detailsNameL.text = object![0].object(forKey: "name") as! String
                    self.detailTypeL.text = object![0].object(forKey: "type") as! String
                    self.detailsAtmosphereL.text = object![0].object(forKey: "atmosphere") as! String
                    if let placeLat = object![0].object(forKey: "lat") as? String{
                        self.chosenLat = Double(placeLat) ?? 0
                    }
                    if let placeLong = object![0].object(forKey: "long") as? String{
                        self.chosenLong = Double(placeLong) ?? 0
                    }
                    
                    if let imageData = object![0].object(forKey: "image") as? PFFileObject{
                        imageData.getDataInBackground { data, error in
                            if error == nil {
                                self.detailsImageView.image = UIImage(data: data!)
                            }
                        }
                    }
                }
                //Maps
                let location = CLLocationCoordinate2D(latitude: self.chosenLat, longitude: self.chosenLong)
                let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                let region = MKCoordinateRegion(center: location, span: span)
                self.detailsMapView.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = self.detailsNameL.text
                annotation.subtitle = self.detailTypeL.text
                self.detailsMapView.addAnnotation(annotation)
            }
            
    
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseID = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else{
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLat != 0.0 && self.chosenLong != 0.0{
            let requestLocation = CLLocation(latitude: self.chosenLat, longitude: self.chosenLong)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detailsNameL.text
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }



}
