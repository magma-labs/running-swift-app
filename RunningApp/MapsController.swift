//
//  ViewController.swift
//  RunningApp
//
//  Created by Alberto Aldana on 13/04/21.
//

import UIKit
import GoogleMaps
import CoreLocation
import FirebaseFirestore

class MapsController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var google_map: GMSMapView!
    @IBOutlet weak var startTrackingBtn: UIButton!
    @IBOutlet weak var LabelTrack: UILabel!
    
    var OurTimer = Timer()
    var TimerDisplayed:Int = 0;
    var timerCounting:Bool = false;
    var locationManager:CLLocationManager!
    var placeMark:CLPlacemark!;
    let db = Firestore.firestore();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        startTrackingBtn.layer.cornerRadius = 15;
        
        // location
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled(){
           locationManager.startUpdatingLocation()
        }
        
        db.collection("locations").document("xAO3usT9ybVN9iSpgg9s").collection("track").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        let camera = GMSCameraPosition(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, zoom: 15.0)
        let geocoder = CLGeocoder();

        print("----> \(userLocation)")
        
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            
            let placemark = placemarks! as [CLPlacemark]
            
            if placemark.count > 0 {
                self.placeMark = placemarks![0]
            }
        }
        
        print("GoogleMapCamera ----> \(google_map.camera.target)")
       let rect = GMSMutablePath()
       rect.add(CLLocationCoordinate2D(latitude: 19.0940143, longitude: -104.301896))
       rect.add(CLLocationCoordinate2D(latitude: 19.0933378, longitude: -104.2997518))
       rect.add(CLLocationCoordinate2D(latitude: 19.1038376, longitude: -104.3089629))
       rect.add(CLLocationCoordinate2D(latitude: 19.1037767, longitude: -104.3089118))
       rect.add(CLLocationCoordinate2D(latitude: 19.1000481, longitude: -104.30522))
       rect.add(CLLocationCoordinate2D(latitude: 19.0944954, longitude: -104.2982817))

       // Create the polygon, and assign it to the map.
       let polyline = GMSPolyline(path: rect)
       polyline.strokeWidth = 5.0
       polyline.geodesic = true
       polyline.map = google_map
        
        self.show_marker(position: google_map.camera.target)
        google_map.camera = camera
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func show_marker(position: CLLocationCoordinate2D) {
        print("---PositionMarker--> \(position)")
        if(self.placeMark != nil) {
            let marker = GMSMarker()
            marker.position = position;
            marker.title = placeMark.locality!
            marker.snippet = placeMark.administrativeArea!
            marker.map = google_map
        }
    }
    
    @IBAction func startTrackingBtn(_ sender: Any) {
        if(timerCounting) {
            timerCounting = false
            OurTimer.invalidate()
            startTrackingBtn.backgroundColor = UIColor.link
            startTrackingBtn.setTitle("START", for: .normal)
            startTrackingBtn.setTitleColor(UIColor.white, for: .normal)
        } else {
            timerCounting = true
            startTrackingBtn.setTitle("RESUME", for: .normal);
            startTrackingBtn.backgroundColor = UIColor.red;
            startTrackingBtn.setTitleColor(UIColor.white, for: .normal);
            OurTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true);
        }
    }
    
    @objc func Action() {
        TimerDisplayed += 1
        let time = secondsToHoursMinutesSeconds(seconds: TimerDisplayed)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        LabelTrack.text = String(timeString)
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
        
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}

