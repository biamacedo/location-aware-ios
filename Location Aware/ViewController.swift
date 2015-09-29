//
//  ViewController.swift
//  Location Aware
//
//  Created by BEATRIZ MACEDO on 9/28/15.
//  Copyright © 2015 Beatriz Macedo. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longiitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0]
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        self.longiitudeLabel.text = "\(userLocation.coordinate.longitude)"
        
        self.courseLabel.text = "\(userLocation.course)"
        
        self.speedLabel.text = "\(userLocation.speed)"
        
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        // Process of going from coordinates to an address
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            
            if error != nil {
                print(error)
            } else {
                
                let p = CLPlacemark(placemark: placemarks![0])
                
                
                var subThoroughfare:String = ""
                var thoroughfare:String = ""
                var subLocality:String = ""
                var subAdministrativeArea:String = ""
                var postalCode:String = ""
                var country:String = ""

                
                if p.subThoroughfare != nil {
                    subThoroughfare = p.subThoroughfare!
                }
                
                if p.thoroughfare != nil {
                    thoroughfare = p.thoroughfare!
                }
                
                if p.subLocality != nil {
                    subLocality = p.subLocality!
                }
                
                if p.subAdministrativeArea != nil {
                    subAdministrativeArea = p.subAdministrativeArea!
                }
                
                if p.postalCode != nil {
                    postalCode = p.postalCode!
                }
                
                if p.country != nil {
                    country = p.country!
                }
                
                self.addressLabel.text = "\(subThoroughfare) \(thoroughfare) \n " +
                "\(subLocality) \n \(subAdministrativeArea) \n \(postalCode) \n \(country)"
                
                
            }
            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

