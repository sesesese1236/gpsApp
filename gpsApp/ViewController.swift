//
//  ViewController.swift
//  gpsApp
//
//  Created by 先生 on 2021/09/16.
//

import UIKit
import CoreLocation
import MapKit
import RealmSwift

class YourExistence : Object{
    @objc dynamic var id:String? = date+time
    @objc dynamic var time:String? = nil
    @objc dynamic var date:String? = nil
    @objc dynamic var latitude:String? = nil
    @objc dynamic var longtitude:String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
class ViewController: UIViewController, CLLocationManagerDelegate{

    
    @IBOutlet weak var labelLat: UILabel!
    @IBOutlet weak var labelLon: UILabel!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    let status = CLLocationManager.authorizationStatus()
    var locationManager : CLLocationManager!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager=CLLocationManager()
        
        locationManager.requestWhenInUseAuthorization()
        if checkAuthorization(){
            locationManager.delegate = self
            locationManager.distanceFilter = 10
//            locationManager.startUpdatingLocation()
        }
        btnStop.isEnabled = false
        
        mapView.mapType = MKMapType.hybrid
        mapUpdate()
    }


    @IBAction func clickStart(_ sender: UIButton) {
        if checkAuthorization(){
            locationManager.startUpdatingLocation()
        }
        mapUpdate()
        switchOnOff()
    }
    
    @IBAction func clickGet(_ sender: UIButton) {
        if checkAuthorization(){
            locationManager.startUpdatingLocation()
        }
        mapUpdate()
        sleep(1)
        locationManager.stopUpdatingLocation()
        mapView.userTrackingMode = MKUserTrackingMode.none
    }
    
    @IBAction func clickStop(_ sender: UIButton) {
        if checkAuthorization(){
            locationManager.stopUpdatingLocation()
        }
        mapView.userTrackingMode = MKUserTrackingMode.none
        switchOnOff()
    }
    
    
    func mapUpdate(){
        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
        mapView.userTrackingMode = MKUserTrackingMode.follow
    }
    
    
    func checkAuthorization() -> Bool{
        if status == CLAuthorizationStatus.authorizedAlways ||
            status == CLAuthorizationStatus.authorizedWhenInUse {
            return true
        }else{
            return false
        }
    }
    
    
    func switchOnOff(){
        btnStart.isEnabled = !(btnStart.isEnabled)
        btnStop.isEnabled = !(btnStop.isEnabled)
    }
    
    
    func locationManager(_ manager:CLLocationManager,didUpdateLocations locations:[CLLocation]){
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longtitude = location?.coordinate.longitude
        print("lantidude\(latitude!). longtitude\(longtitude!)")
        labelLat.text = String(latitude!)
        labelLon.text = String(longtitude!)
    }
}

