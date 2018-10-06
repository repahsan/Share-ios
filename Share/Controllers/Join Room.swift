//
//  Join Room.swift
//  Share
//
//  Created by Caryl Rabanos on 02/10/2018.
//  Copyright © 2018 Caryl Rabanos. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces
import SwiftyJSON
class Join_Room: UIViewController ,GMSMapViewDelegate , CLLocationManagerDelegate {
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet weak var destinationLocation: UIButton!
    @IBOutlet weak var startLocation: UIButton!
    var dest = [String]()
    var orig = [String]()
    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation
    
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //selecting start location
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
    //selecting destination
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Join_Room: GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        //Set Coordinate to Text
        if locationSelected == .startLocation{
            startLabel.text = "\(place.name)"
            locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        }else{
            destinationLabel.text = "\(place.name)"
            locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        }
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
