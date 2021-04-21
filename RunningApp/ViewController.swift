//
//  ViewController.swift
//  RunningApp
//
//  Created by Alberto Aldana on 13/04/21.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    @IBOutlet weak var google_map: GMSMapView!
    @IBOutlet weak var startTrackingBtn: UIButton!
    @IBOutlet weak var LabelTrack: UILabel!
    
    var OurTimer = Timer()
    var TimerDisplayed:Int = 0;
    var timerCounting:Bool = false;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let camera = GMSCameraPosition(latitude: 19.0522, longitude: -104.316, zoom: 6.0)
        google_map.camera = camera
        self.show_marker(position: google_map.camera.target)
        
        startTrackingBtn.layer.cornerRadius = 15;
    }
    
    func show_marker(position: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = position
        marker.title = "Colima"
        marker.snippet = "Capital Of Manzanillo"
        marker.map = google_map
    }
    
    @IBAction func startTrackingBtn(_ sender: Any) {
        if(timerCounting) {
            timerCounting = false
            OurTimer.invalidate()
            startTrackingBtn.setTitle("START", for: .normal)
            startTrackingBtn.setTitleColor(UIColor.green, for: .normal)
        } else {
            timerCounting = true
            startTrackingBtn.setTitle("STOP", for: .normal)
            startTrackingBtn.setTitleColor(UIColor.red, for: .normal)
            OurTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
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

