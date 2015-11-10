//
//  PasswordController.swift
//  Ed And Tara's Wedding
//
//  Created by Edmund Dipple on 10/11/2015.
//  Copyright © 2015 Edmund Dipple. All rights reserved.
//

import UIKit



class PasswordViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainTabViewController") as UIViewController
        self.presentViewController(viewController, animated: false, completion: nil)
    }
    
}