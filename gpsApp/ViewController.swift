//
//  ViewController.swift
//  gpsApp
//
//  Created by 先生 on 2021/09/16.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var labelLat: UILabel!
    @IBOutlet weak var labelLon: UILabel!
    
    var locationManager : CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager=CLLocationManager()
        
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.authorizedAlways{
            locationManager.delegate = self
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
    }


    @IBAction func clickGet(_ sender: UIButton) {
    }
    func locationManager(manager:CLLocationManager,didUpdateLocations locations:[CLLocation]){
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longtitude = location?.coordinate.longitude
        print("lantidude\(latitude!). longtitude\(longtitude!)")
    }
}

