//
//  PasswordController.swift
//  Ed And Tara's Wedding
//
//  Created by Edmund Dipple on 10/11/2015.
//  Copyright © 2015 Edmund Dipple. All rights reserved.
//

import UIKit
import AVFoundation


class PasswordViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var scanButton: UIButton!
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainTabViewController") as UIViewController
        //self.presentViewController(viewController, animated: false, completion: nil)
    }
    
    @IBAction func pressScanButton(sender: AnyObject) {
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
       
        var input: AnyObject!
        do{
            try input = AVCaptureDeviceInput(device: captureDevice)
        }catch let error as NSError {
            // If any error occurs, simply log the description of it and don't continue any more.
            print("\(error.localizedDescription)")
            return
        }
        
        // Initialize the captureSession object.
        captureSession = AVCaptureSession()
        // Set the input device on the capture session.
        captureSession?.addInput(input as! AVCaptureInput)
        
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        captureSession?.startRunning()
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
    }
}