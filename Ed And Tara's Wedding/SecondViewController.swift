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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // create a region and pass it to the Map View
        var region = MKCoordinateRegion();
        region.center.latitude = 51.760453;
        region.center.longitude = -0.209228;
        region.span.latitudeDelta = 0.011;
        region.span.longitudeDelta = 0.011;
        
        mapView.setRegion(region, animated: true);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

