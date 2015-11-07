//
//  InfoViewController.swift
//  Ed And Tara's Wedding
//
//  Created by Edmund Dipple on 07/11/2015.
//  Copyright © 2015 Edmund Dipple. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var infoWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadInfoFile()
    }
    
    func loadInfoFile() {
        let requestUrl = NSBundle.mainBundle().URLForResource("info", withExtension:"html")
        let request = NSURLRequest(URL: requestUrl!)
        infoWebView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

