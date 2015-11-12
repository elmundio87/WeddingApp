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
    
    @IBOutlet weak var manualPasswordLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var passwordButton: UIButton!
    
    @IBOutlet var passwordField: UITextField?
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    var savePassword = NSBundle.mainBundle().infoDictionary!["SavePassword"] as! Bool

    
    override func viewDidLoad(){
        super.viewDidLoad()
        passwordButton.layer.cornerRadius = 10.0
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if(NSUserDefaults.standardUserDefaults().boolForKey("password") && savePassword){
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainTabViewController") as UIViewController
            self.presentViewController(viewController, animated: false, completion: nil)
        }else{
            startScanning()
        }
        
    }
    
    func validatePassWord(password: String) -> Bool{
        let data = NSData(base64EncodedString: "U1RBUldBUlNEQVk=", options: NSDataBase64DecodingOptions(rawValue: 0))
        let base64Decoded = NSString(data: data!, encoding: NSUTF8StringEncoding)
        return (base64Decoded == password)
       
    }
    
    func openSesame(password: String){
        if(validatePassWord(password)){
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "password")
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainTabViewController") as UIViewController
            self.presentViewController(viewController, animated: false, completion: nil)
        }else{
            
            if #available(iOS 8.0, *) {
                let alert =  UIAlertController(title: "Incorrect password", message:
                        "Please enter the password included in your invitation", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style:.Default, handler: nil))
                self.presentViewController(alert, animated: true){}
                

            } else {
                let alert: UIAlertView = UIAlertView()
                alert.title = "Incorrect password"
                alert.message = "Please enter the password included in your invitation"
                alert.addButtonWithTitle("OK")
                alert.show()
            }
            
        }
    }
    
    func startScanning() {
        
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
        view.bringSubviewToFront(messageLabel)
        view.bringSubviewToFront(passwordButton)
        view.bringSubviewToFront(manualPasswordLabel)
        messageLabel?.textColor = UIColor.whiteColor()
        manualPasswordLabel?.textColor = UIColor.whiteColor()

    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds;
            
            if metadataObj.stringValue != nil {
                openSesame(metadataObj.stringValue);
                tearDownVideo();
            }
        }
    }
    
    func tearDownVideo(){
        captureSession?.stopRunning()
        videoPreviewLayer?.removeFromSuperlayer();
        qrCodeFrameView?.removeFromSuperview();
    }
    
    
 
    @IBAction func touchPasswordTextbox(sender: AnyObject){
        
        if #available(iOS 8.0, *) {
        
            func passwordEntered(alert: UIAlertAction){
                let password = self.passwordField!.text
                openSesame(password!)
            }
            
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "Enter password",
            message: "The password is included in your invitation",
            preferredStyle: .Alert)
            
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                self.passwordField = textField
                textField.placeholder = "Enter the password"
        })
            
         alertController!.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: passwordEntered))
      
        self.presentViewController(alertController!,
            animated: true,
            completion: nil)
        }else{
            
            func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
              let password = View.textFieldAtIndex(0)!.text
              openSesame(password!)
            }
            
            let alert: UIAlertView = UIAlertView()
            alert.delegate = self
            alert.title = "Enter password"
            alert.message = "The password is included in your invitation"
            alert.addButtonWithTitle("OK")
            alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        
            alert.show()

        }
    }
}