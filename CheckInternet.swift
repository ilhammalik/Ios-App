//
//  CheckInternet.swift
//  Pay4date
//
//  Created by kufed-ios on 8/17/16.
//  Copyright © 2016 Ilham Malik Ibrahim. All rights reserved.
//

import Foundation
import UIKit

 class CheckInternet : UIViewController {
    

    func Check(){
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            print("Internet connection FAILED")
            // Initialize Alert Controller
            var alert = UIAlertController(title: "Cannot connect  to network", message: "Please check connection internet ", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Go to Setting", style: .Default, handler: { (action: UIAlertAction!) in
                print("Go to Setting")
                UIApplication.sharedApplication().openURL(NSURL(string:"prefs:root=Setting")!)
            }))
            // Present Alert Controller
            presentViewController(alert, animated: true, completion: nil)
        }
    }
}