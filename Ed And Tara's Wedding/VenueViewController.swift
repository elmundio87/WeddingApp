//
//  VenueViewController.swift
//  Ed And Tara's Wedding
//
//  Created by Edmund Dipple on 09/11/2015.
//  Copyright © 2015 Edmund Dipple. All rights reserved.
//

import UIKit


class VenueViewController: UIViewController, UIWebViewDelegate {
    

    @IBOutlet weak var openInSafariButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var connectionTimeoutLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var refreshButton: UIButton!
    
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
        loadAddressUrl()
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
        loadingView.hidden = true
        
        if(webView.hidden){
            let animation:CATransition = CATransition()
            animation.type = kCATransitionFade
            animation.duration = 0.7;
            webView.layer.addAnimation(animation, forKey:nil)
            webView.hidden = false
        }
    }
  
    @IBAction func openInSafari(){
        let url = NSURL(string: urlPath)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBAction func goBackButton(){
        webView.goBack()
    }
    
    @IBAction func goForwardButton(){
        webView.goForward()
    }
    
}