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
    @objc dynamic var id:String = NSUUID().uuidString
    @objc dynamic var time:Date? = nil
    @objc dynamic var latitude:Double = 0
    @objc dynamic var longtitude:Double = 0
    
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
    public var startDate:Date? = nil
    public var stopDate:Date? = nil
    let userCalendar = Calendar.current
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager=CLLocationManager()
        
        
        
        let config = Realm.Configuration(schemaVersion:1)
        Realm.Configuration.defaultConfiguration = config
        
        locationManager.requestWhenInUseAuthorization()
        if checkAuthorization(){
            locationManager.delegate = self
            locationManager.distanceFilter = 10
//            locationManager.startUpdatingLocation()
        }
        btnStop.isEnabled = false
        
        mapView.mapType = MKMapType.hybrid
        mapUpdate()
        
        mapView.removeAnnotations(mapView.annotations)
        
        if(startDate != nil && stopDate != nil){
            annotation()
        }
    }


    @IBAction func clickStart(_ sender: UIButton) {
        if checkAuthorization(){
            locationManager.startUpdatingLocation()
        }
        mapUpdate()
        switchOnOff()
    }
    
    @IBAction func clickSearch(_ sender: UIButton) {
        if checkAuthorization(){
            if(btnStart.isEnabled == false){
                locationManager.stopUpdatingLocation()
                mapView.userTrackingMode = MKUserTrackingMode.none
                
                btnStop.isEnabled = false
                btnStart.isEnabled = true
            }
        }
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
        let db : YourExistence = YourExistence()
        let realm = try! Realm()
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longtitude = location?.coordinate.longitude
        let currentDateTime = Date()
        print("lantidude\(latitude!). longtitude\(longtitude!)")
        
        db.time = currentDateTime
        db.latitude = latitude!
        db.longtitude = longtitude!
        
        try! realm.write {
            realm.add(db)
        }
        
        
        labelLat.text = String(latitude!)
        labelLon.text = String(longtitude!)
        
        let dbList: Results<YourExistence> = realm.objects(YourExistence.self)
        
        for db in dbList{
            print(db.id)
            print(db.time!)
            print(db.latitude)
            print(db.longtitude)
            print()
            print()
        }
    }
    func annotation(){
        let realm = try! Realm()
        print(startDate!)
        print(stopDate!)
        let gpsList:Results<YourExistence> = realm.objects(YourExistence.self).filter("time <= %@ AND time >= %@", stopDate! ,startDate!)
        
        let dateformatter = DateFormatter()
//        print("test")
        for loc in gpsList{
            let annonation:MKPointAnnotation = MKPointAnnotation()
            annonation.coordinate = CLLocationCoordinate2DMake(loc.latitude, loc.longtitude)
            annonation.title = "You"
            annonation.subtitle = dateformatter.string(from:loc.time!)
            mapView.addAnnotation(annonation)
//            print("test2")
        }
    }
}

