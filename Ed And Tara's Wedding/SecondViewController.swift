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

class SecondViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var myLocation: UIButton!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        goToHatfieldHouse();
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        manager.requestWhenInUseAuthorization()
        
        var hatfieldHouseAnnotation = MKPointAnnotation()
        hatfieldHouseAnnotation.coordinate = CLLocationCoordinate2DMake(51.760453, -0.209228);
        hatfieldHouseAnnotation.title = "The Old Palace";
        hatfieldHouseAnnotation.subtitle = "Hatfield House";
        //locations.append(hatfieldHouseAnnotation)
        mapView.addAnnotation(hatfieldHouseAnnotation);
    
        mapView.showsUserLocation = true
        
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
        userLoc = mapView.userLocation.location;
        userCoordinate = userLoc.coordinate;
        
        var region = MKCoordinateRegion();
        region.center.latitude = userCoordinate.latitude;
        region.center.longitude = userCoordinate.longitude;
        region.span.latitudeDelta = 0.011;
        region.span.longitudeDelta = 0.011;
        
        mapView.setRegion(region, animated: true);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

