//
//  AppDelegate.swift
//  Custom URL Scheme Xcode 7
//
//  Created by PJ Vea on 8/16/15.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import SystemConfiguration
import Alamofire
import RealmSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        UINavigationBar.appearance().tintColor = UIColor(red: 95/255.0, green: 138/255.0, blue: 222/255.0, alpha: 1.0)
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName :UIColor(red: 95/255.0, green: 138/255.0, blue: 222/255.0, alpha: 1.0)]
        
        
        
        //get Profile data
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        
        return true
    }
    
    func dateComponentFromNSDate(date: NSDate)-> NSDateComponents{
        
        let calendarUnit: NSCalendarUnit = [.Hour, .Day, .Month, .Year]
        let dateComponents = NSCalendar.currentCalendar().components(calendarUnit, fromDate: date)
        return dateComponents
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool
    {
        let urlString = "\(url)"
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let Key = prefs.valueForKey("key") as? String
        let reset = prefs.valueForKey("resetPassword") as? String
        let tok = "cheers://recovery/confirmation/password/"+String(reset!)
        
        print("Token Confirm",tok)
        print(url)
        
        if urlString == "cheers://confirm"
        {
            print("Token Success")
            let headers = [
                "appid": AppId,
                "secretkey": SecretKey,
                "cache-control": CacheControl,
                "content-type": ContentType,
                "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                "Accept": "application/json",
                ]
            
            let body = [
                "activation_key": "\(Key)",
                ]
            
            Alamofire.request(.POST, ApiConfirm,parameters:body, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    let result = response.result.value as? [String : AnyObject ]
                    print(result!["response"]!["message"]!)
                    if (response.response!.statusCode == 200 && response.response!.statusCode < 300 ) {
                        if  let result = response.result.value as? [String : AnyObject]{
                            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                            var mainViewController = LoginController(nibName: "Login", bundle: nil)
                            var navigationController = UINavigationController(rootViewController: mainViewController)
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Activation SUCCESS"
                            alertView.message = "SUCCESS Thanks"
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                            
                        }else{
                            let result = response.result.value as? [String : AnyObject ]
                            print(result!["response"]!["message"]!)
                        }
                        
                    }
                    
            }
        }
        
        if urlString ==  tok        {
            print("forget Password suksess")
            print(String(reset!))
            window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            window = UIWindow(frame: UIScreen.mainScreen().bounds)

            
            var mainViewController = SetPasswordController(nibName: "SetPassword", bundle: nil)
            var navigationController = UINavigationController(rootViewController: mainViewController)
            
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
            
        }
        return true
    }
    
    
}

