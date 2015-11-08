//
//  MapViewController.swift
//  Ed And Tara's Wedding
//
//  Created by Edmund Dipple on 07/11/2015.
//  Copyright © 2015 Edmund Dipple. All rights reserved.
//

import UIKit
import MapKit

let image = "map.jpg"
var imageView: UIImageView!
var scrollView: UIScrollView!

class MapViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var containerView: UIView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        redraw()

    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        super.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
        redraw()
    }
    
    func redraw(){
        for subview in containerView.subviews {
            subview.removeFromSuperview()
        }
        
        imageView = UIImageView(image: UIImage(named: image))
        
        // 2
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.whiteColor()
        // 3
        
        if(view.bounds.width <= 490 ){
            scrollView.contentSize = imageView.bounds.size
        }else{
            scrollView.contentSize = view.bounds.size
            imageView.contentMode = .ScaleAspectFit
        }
        
        // 4
        scrollView.addSubview(imageView)
        containerView.addSubview(scrollView)
        
        imageView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
   
        scrollView.maximumZoomScale = 1.0
        scrollView.minimumZoomScale = 0.5
        scrollView.delegate = self
        
        
        
        let scrollPoint = CGPointMake(50, 0.0)
        scrollView.setContentOffset(scrollPoint, animated: false)
        scrollView.zoomScale = 1.0
        
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @IBAction func openMapForPlace(sender: AnyObject) {
        let regionDistance: CLLocationDistance = 500
        let coordinates = CLLocationCoordinate2DMake(51.760453, -0.209228);
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        
        MKMapItem.openMapsWithItems([], launchOptions: options)
    }
    
    
}