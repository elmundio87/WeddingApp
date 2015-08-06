//
//  SecondViewController.swift
//  Ed And Tara's Wedding
//
//  Created by Edmund Dipple on 25/07/2015.
//  Copyright (c) 2015 Edmund Dipple. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var myLocation: UIButton!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        goToHatfieldHouse();
        
        locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        var hatfieldHouseAnnotation = MKPointAnnotation()
        hatfieldHouseAnnotation.coordinate = CLLocationCoordinate2DMake(51.760453, -0.209228);
        hatfieldHouseAnnotation.title = "The Old Palace";
        hatfieldHouseAnnotation.subtitle = "Hatfield House";

        mapView.addAnnotation(hatfieldHouseAnnotation);
    
        mapView.showsUserLocation = true
        
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        println("locations = \(locations)")
        println("success")
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        println("Error: " + error.localizedDescription)
    }
    
    @IBAction func goToHatfieldHouse(){
        
        var region = MKCoordinateRegion();
        region.center.latitude = 51.760453;
        region.center.longitude = -0.209228;
        region.span.latitudeDelta = 0.011;
        region.span.longitudeDelta = 0.011;
        
        mapView.setRegion(region, animated: true);
        
    }
    
    @IBAction func goToMyLocation(){
        var userLoc: CLLocation
        var userCoordinate: CLLocationCoordinate2D!
        
        if locationManager.location != nil {
            println("\(locationManager.location.coordinate.latitude), \(locationManager.location.coordinate.longitude)")
            userLoc = mapView.userLocation.location;
            userCoordinate = userLoc.coordinate;
            
            var region = MKCoordinateRegion();
            region.center.latitude = userCoordinate.latitude;
            region.center.longitude = userCoordinate.longitude;
            region.span.latitudeDelta = 0.011;
            region.span.longitudeDelta = 0.011;
            
            mapView.setRegion(region, animated: true);

        } else {
            println("locationManager.location is nil")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

