//
//  VenueViewController.swift
//  Ed And Tara's Wedding
//
//  Created by Edmund Dipple on 09/11/2015.
//  Copyright © 2015 Edmund Dipple. All rights reserved.
//

import UIKit


class VenueViewController: UIViewController, UIWebViewDelegate {
    

    @IBOutlet weak var connectionTimeoutLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var refreshButton: UIButton!
    
    var timer = NSTimer()
    let connectionTimeout = NSBundle.mainBundle().infoDictionary!["WebViewConnectionTimeout"] as! Double
    var loaded = false;
    
    var urlPath = "http://hatfield-house.co.uk"
    
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
        if(!loaded){
        loadingView.hidden = true
        refreshButton.hidden = false
        connectionTimeoutLabel.hidden = false
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "about:blank")!))
        }
    }
  
    
}