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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let camera = GMSCameraPosition(latitude: 19.0522, longitude: -104.316, zoom: 6.0)
        google_map.camera = camera
        self.show_marker(position: google_map.camera.target)
    }
    
    func show_marker(position: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = position
        marker.title = "Colima"
        marker.snippet = "Capital Of Manzanillo"
        marker.map = google_map
    }
}

