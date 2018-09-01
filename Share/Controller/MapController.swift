//
//  MapsController.swift
//  Share
//
//  Created by Dominique Michael Abejar on 01/09/2018.
//  Copyright © 2018 Caryl Rabanos. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces
import SwiftyJSON

enum Location{
    case startLocation
    case destinationLocation
}

class MapController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var googleApiKey = "AIzaSyCp0xOx8p6ROiquRXqT53038ujLHbdRMRw"
    
    
    @IBOutlet weak var googleMaps: GMSMapView!
    @IBOutlet weak var startLocation: UITextField!
    @IBOutlet weak var destinationLocation: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(homepage))
        
        maps()
    
        
    }
    


    @objc func maps () {

        GMSServices.provideAPIKey(googleApiKey)
        
        //Map View UI
        let camera = GMSCameraPosition.camera(withLatitude: 10.471320, longitude: 123.701778, zoom: 10)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        
        //Marker (Red Pin)
        let currentLocation = CLLocationCoordinate2D(latitude: 10.471320, longitude: 123.701778)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Starting Point"
        marker.map = mapView
    }

    @objc func homepage() {
        let homepageController = ViewController()
        present(homepageController, animated: true, completion: nil)

    }

    
}
