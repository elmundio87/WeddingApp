//
//  FirstViewController.swift
//  Ed And Tara's Wedding
//
//  Created by Edmund Dipple on 25/07/2015.
//  Copyright (c) 2015 Edmund Dipple. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var urlPath = "https://goo.gl/forms/M6g53EQEai"
    
    func loadAddressUrl() {
        let requestUrl = NSURL(string: urlPath)
        let request = NSURLRequest(URL: requestUrl!)
        webView.loadRequest(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadAddressUrl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    

}

