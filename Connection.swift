//
//  ViewController.swift
//  youtube_demo4
//
//  Created by Brian Voong on 2/17/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

//
//  ViewController.swift
//  youtube_demo4
//
//  Created by Brian Voong on 2/17/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit



class Connection: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
     CheckInternet()
    }
    
    func CheckInternet(){
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            
            print("Internet connection FAILED")
            
            // Initialize Alert Controller
            var alert = UIAlertController(title: "Cannot connect  to network", message: "Please check connection internet ", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Go to Setting", style: .Default, handler: { (action: UIAlertAction!) in
                print("Go to Setting")
                UIApplication.sharedApplication().openURL(NSURL(string:"prefs:root=General")!)
            }))
            
            //            alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            //                print("Cancel")
            //            }))
            
            presentViewController(alert, animated: true, completion: nil)
            // Present Alert Controller
            //UIApplication.sharedApplication().openURL(NSURL(string:"prefs:root=General")!)
            
            
        }
        
        
    }
}




