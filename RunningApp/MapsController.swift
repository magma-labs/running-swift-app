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
    @IBOutlet weak var saveTrackingBtn: UIButton!
    
    var OurTimer = Timer()
    var TimerDisplayed:Int = 0;
    var timerCounting:Bool = false;
    var locationManager:CLLocationManager!
    var placeMark:CLPlacemark!;
    let db = Firestore.firestore();

    override func viewDidLoad() {
        super.viewDidLoad()
        startTrackingBtn.layer.cornerRadius = 15;
        saveTrackingBtn.layer.cornerRadius = 15;

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
           locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        let camera = GMSCameraPosition(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, zoom: 15.0)
        let geocoder = CLGeocoder();
        let uid:String = UserDefaults.standard.string(forKey: "uid")!;
        
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil) {
                print("error in reverseGeocode")
            }
            
            let placemark = placemarks! as [CLPlacemark]
            
            if placemark.count > 0 {
                self.placeMark = placemarks![0]
            }
        }
                
        /* db.collection("locations").document(uid).collection("sessions").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let rect = GMSMutablePath()

                for document in querySnapshot!.documents {
                    let latlongs = document.data()
                    
                    let latitude:Double = latlongs["lat"] as! Double
                    let longitude:Double = latlongs["lng"] as! Double
                    
                    rect.add(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                }
                
                let polyline = GMSPolyline(path: rect)
                polyline.strokeWidth = 5.0
                polyline.geodesic = true
                polyline.map = self.google_map
                 
                self.show_marker(position: self.google_map.camera.target)
                google_map.camera = camera
            }
        } */
    }
    
    func getFormattedDate(date: Date, format: String) -> String {
            let dateformat = DateFormatter()
            dateformat.dateFormat = format
            return dateformat.string(from: date)
    }

    func addPosition() {
        let manager = CLLocationManager()
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let uid:String = UserDefaults.standard.string(forKey: "uid")!;
        let documentID:String = UserDefaults.standard.string(forKey: "documentID")!;
        var ref: DocumentReference? = nil
        let session = DispatchGroup()
        let formatingDate = getFormattedDate(date: Date(), format: "dd-MMM-yyyy HH:mm:ss")
                              
        DispatchQueue.main.async {
            if (documentID == "") {
                ref = self.db.collection("racings")
                        .document(uid)
                        .collection("\(formatingDate)")
                        .addDocument(data: [
                            "latitude": locValue.latitude,
                            "longitude": locValue.longitude,
                            "timestamp": formatingDate
                        ]){ [self] err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                let defaults = UserDefaults.standard
                                defaults.set("\(formatingDate)", forKey: "documentID")
                            }
                        }
            }
        }
        
        session.notify(queue: .main) {
            print("\(documentID)")
            
            if(documentID != "") {
                self.db.collection("racings")
                        .document(uid)
                        .collection("\(documentID)")
                        .addDocument(data: [
                            "latitude": locValue.latitude,
                            "longitude": locValue.longitude,
                            "timestamp": formatingDate
                        ])
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func show_marker(position: CLLocationCoordinate2D) {
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
    
    @IBAction func saveTrackingBtn(_ sender: Any) {
       let alert = UIAlertController(title: "Finish session", message: "Are you sure to finish the racing?", preferredStyle: UIAlertController.Style.alert)

       alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil ))
       
       alert.addAction(UIAlertAction(title: "Finish", style: UIAlertAction.Style.default, handler: { action in
            print("Closing session")
            let defaults = UserDefaults.standard
            defaults.set("", forKey: "documentID")
       }))
        
       self.present(alert, animated: true, completion: nil)
        
       
    }
    
    @objc func Action() {
        TimerDisplayed += 1
        let time = secondsToHoursMinutesSeconds(seconds: TimerDisplayed)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        LabelTrack.text = String(timeString);
        
        self.addPosition()
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

