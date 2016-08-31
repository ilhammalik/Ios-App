//
//  ViewController.swift
//  Pay4Date
//
//  Created by Ilham Malik Ibrahim on 7/22/16.
//  Copyright © 2016 kufed-ios. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import EventKit

class Launch: UIViewController,BWWalkthroughViewControllerDelegate {
    /* Variabel */
    
    /* End Variabel */
    var needWalkthrough:Bool = true
    var walkthrough:BWWalkthroughViewController!
    

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        print("Controller Launch\n\n")
        checkToken()

    }
    
    @IBAction func tampil(){
        
        let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
        walkthrough = stb.instantiateViewControllerWithIdentifier("container") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewControllerWithIdentifier("page_1")
        let page_two = stb.instantiateViewControllerWithIdentifier("page_2")
        let page_three = stb.instantiateViewControllerWithIdentifier("page_3")
 
        
        // Attach the pages to the master
        walkthrough.delegate = self
        walkthrough.addViewController(page_one)
        walkthrough.addViewController(page_two)
        walkthrough.addViewController(page_three)

        self.presentViewController(walkthrough, animated: true) {
            ()->() in
            self.needWalkthrough = false
        }
    }
    

    func checkToken(){
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let Token = prefs.valueForKey("token") as? String
        if(Token != nil){
            let headersToken = [
                "appid": "4201620",
                "secretkey": SecretKey,
                "cache-control": CacheControl,
                "content-type": ContentType,
                "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                "Accept": "application/json",
                "authtoken":String(Token!),
                ]
            Alamofire.request(.GET, ApiProfile, headers: headersToken)
                .responseJSON { (response) -> Void in
                    debugPrint(response)
                    if (response.response!.statusCode == 401 || response.response!.statusCode == 403 || response.response!.statusCode == 409 ){
                        debugPrint(response)
//                        var alert = UIAlertController(title: "Device is Logout", message: "your device is login other device ", preferredStyle: UIAlertControllerStyle.Alert)
//                        alert.addAction(UIAlertAction(title: "Close", style: .Default, handler: { (action: UIAlertAction!) in
//                            print("Close")
//                            let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
//                            Login.setInteger(0, forKey: "ISLOGGEDIN")
//                            Login.synchronize()
//                            exit(0)
//                            
//                        }))
                        let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        Login.setInteger(0, forKey: "ISLOGGEDIN")
                        Login.synchronize()

                        self.tampil()
//                        alert.addAction(UIAlertAction(title: "Login", style: .Default, handler: { (action: UIAlertAction!) in
//                            print("Close")
//                            
//                            let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
//                            Login.setInteger(0, forKey: "ISLOGGEDIN")
//                            Login.synchronize()
//                            
//                            let vc = LoginController(nibName: "Login", bundle: nil)
//                            var navb = UINavigationController(rootViewController: vc)
//                            self.presentViewController(navb, animated:true, completion:nil)
//                            
//
//                        }))
                        
                        // Present Alert Controller
                        //self.presentViewController(alert, animated: true, completion: nil)
                        
                    }else if(response.response!.statusCode == 200 || response.response!.statusCode == 201 ){
                        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
                        print(isLoggedIn)
                        if (isLoggedIn == 1) {
                            print("is Login")
                            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("home") as! HomeController
                            let navigationController = UINavigationController(rootViewController: vc)
                            self.presentViewController(navigationController, animated: true, completion: nil)
                            
                        }else{
                            print("is Guest")
                           self.tampil()

//                            let vc = FirstController(nibName: "First", bundle: nil)
//                            self.presentViewController(vc, animated:true, completion:nil)
//                            
                        }
                        
                    }
                    
            }
        }else{
            print("Token kosong")
            let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            Login.setInteger(0, forKey: "ISLOGGEDIN")
            Login.synchronize()
            
           self.tampil()
        }
    }
    
    
}

extension Launch{
    
    func walkthroughCloseButtonPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func walkthroughPageDidChange(pageNumber: Int) {
        if (self.walkthrough.numberOfPages - 1) == pageNumber{
            self.walkthrough.closeButton?.hidden = false
        }else{
            self.walkthrough.closeButton?.hidden = true
        }
    }
    
}









