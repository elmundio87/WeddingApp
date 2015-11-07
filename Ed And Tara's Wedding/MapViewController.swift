//
//  MapViewController.swift
//  Ed And Tara's Wedding
//
//  Created by Edmund Dipple on 07/11/2015.
//  Copyright © 2015 Edmund Dipple. All rights reserved.
//

import UIKit

let image = "map.png"
var imageView: UIImageView!
var scrollView: UIScrollView!

class MapViewController: UIViewController, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
        imageView = UIImageView(image: UIImage(named: image))
        // 2
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.blackColor()
        // 3
    
        scrollView.contentSize = imageView.bounds.size
        // 4
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        
        imageView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 0.5
        scrollView.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
    
    
}