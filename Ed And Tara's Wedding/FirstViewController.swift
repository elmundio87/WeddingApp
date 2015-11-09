//
//  FirstViewController.swift
//  Ed And Tara's Wedding
//
//  Created by Edmund Dipple on 25/07/2015.
//  Copyright (c) 2015 Edmund Dipple. All rights reserved.
//

import UIKit
import QuartzCore

class FirstViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var connectionTimeoutLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var webView: UIWebView!
    var timer = NSTimer()
    let connectionTimeout = 20.0
    var loaded = false;
    
    var urlPath = "https://goo.gl/forms/p1u4pa2WgA"
    
    func loadAddressUrl() {
        let requestUrl = NSURL(string: urlPath)
        let request = NSURLRequest(URL: requestUrl!)
        webView.loadRequest(request)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.layer.cornerRadius = 10.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Do any additional setup after loading the view, typically from a nib.
        webView.delegate = self
        if(!loaded){
            loadAddressUrl()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshButtonTouchUpInside(sender: AnyObject) {
        webView.stopLoading()
        loadAddressUrl()
        refreshButton.hidden = true
        connectionTimeoutLabel.hidden = true
    }

    
    func webViewDidFinishLoad(webView: UIWebView ) {
        loaded = true
        loadingView.hidden = true
        timer.invalidate()
    }

    func webViewDidStartLoad(webView: UIWebView) {
        loadingView.hidden = false
        timer = NSTimer.scheduledTimerWithTimeInterval(connectionTimeout, target: self, selector: "cancelWeb:", userInfo: nil, repeats: false)
    }
    
    func cancelWeb(timer: NSTimer){
        loadingView.hidden = true
        refreshButton.hidden = false
        connectionTimeoutLabel.hidden = false
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "about:blank")!))
    }
    

}

