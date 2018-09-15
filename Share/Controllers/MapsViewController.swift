//
//  MapsViewController.swift
//  Share
//
//  Created by Dominique Michael Abejar on 07/09/2018.
//  Copyright © 2018 Caryl Rabanos. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire
import Firebase

enum Location{
    case startLocation
    case destinationLocation
}
class MapsViewController: UIViewController , GMSMapViewDelegate , CLLocationManagerDelegate {
    
    
    @IBOutlet weak var googleMaps : GMSMapView!
    @IBOutlet weak var startLocation : UITextField!
    @IBOutlet weak var destinationLocation : UITextField!
    
    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation
    
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        //Map initiation Code
        
        let camera = GMSCameraPosition.camera(withLatitude: 10.3540762, longitude: 123.9115758, zoom: 15.0)
        
        self.googleMaps.camera = camera
        self.googleMaps.delegate = self
        self.googleMaps?.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
        
    }
    
    //Create Marker Pin on map function
    
    func createMarker(titleMarker : String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = titleMarker
        marker.icon = GMSMarker.markerImage(with: .red)
        marker.map = googleMaps
    }
    
    //Location Manager Delegates
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting loation : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let location = locations.last
        
        let locationTarget = CLLocation(latitude: 10.3540762, longitude: 123.9115758)
        
        createMarker(titleMarker: "Destination Location", iconMarker: #imageLiteral(resourceName: "mapspin"), latitude: locationTarget.coordinate.latitude, longitude: locationTarget.coordinate.longitude)
        
        createMarker(titleMarker: "Starting Location", iconMarker: #imageLiteral(resourceName: "mapspin") , latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        
        drawPath(startLocation: location!, endLocation: locationTarget)
        
        self.locationManager.stopUpdatingLocation()
        
    }
    
    //GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        googleMaps.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        googleMaps.isMyLocationEnabled = true
        
        if(gesture){
            mapView.selectedMarker = nil
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        googleMaps.isMyLocationEnabled = true
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("COORDINATE \(coordinate)")
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        googleMaps.isMyLocationEnabled = true
        googleMaps.selectedMarker = nil
        return false
    }
    
    //Create route path from start to destination
    
    func drawPath(startLocation: CLLocation, endLocation: CLLocation)
    {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            do{
                let json = try JSON(data: response.data!)
                let routes = json["routes"].arrayValue
                
                
                print(json)
                
                // print route using Polyline
                for route in routes
                {
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline?["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeWidth = 4
                    polyline.strokeColor = UIColor.red
                    polyline.map = self.googleMaps
                }
                
            }catch{
                print(error)
            }
            
        }
    }
    
    //Tapping Start Location will open the search function
    
    @IBAction func openStartLocation(_ sender: UIButton) {
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        //Selected Location
        locationSelected = .startLocation
        
        //Change Text Color
        UISearchBar.appearance().setTextColor(color: UIColor.red)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    //Tapping Destination Location will open the search function
    
    @IBAction func openDestinationLocation(_ sender: UIButton){
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        //Selected location
        locationSelected = .destinationLocation
        
        //Change Text Color
        UISearchBar.appearance().setTextColor(color: UIColor.red)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    @IBAction func showDirection(_ sender: UIButton) {
        let ref = Database.database().reference(fromURL: "https://share-a8ca4.firebaseio.com/")
        let values = ["Origin": startLocation.text, "Destination": destinationLocation.text]
        //When Show Direction Button is tapped it will call drawpath function'
        self.drawPath(startLocation: locationStart, endLocation: locationEnd)
        ref.child("travel").childByAutoId().setValue(values, withCompletionBlock: {(err,ref) in
            if err != nil{
                print(err?.localizedDescription as Any)
                return
            }
            
        })
    }
}

// Auto Complete Delegate, For autocompleter search location
extension MapsViewController: GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        //Change Map Location
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0)
        
        //Set Coordinate to Text
        if locationSelected == .startLocation{
            startLocation.text = "\(place.name)"
            locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            createMarker(titleMarker: "Location Start", iconMarker: GMSMarker.markerImage(with: .black), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        }else{
            destinationLocation.text = "\(place.name)"
            locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            createMarker(titleMarker: "Location End", iconMarker: GMSMarker.markerImage(with: .black), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        }
        
        self.googleMaps.camera = camera
        self.dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error \(error)")
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
}

public extension UISearchBar{
    
    public func setTextColor(color: UIColor){
        
        let svs = subviews.flatMap { $0.subviews}
        guard let tf = (svs.filter {$0 is UITextField }).first as? UITextField else { return }
        
        tf.textColor = color
        
    }
}
