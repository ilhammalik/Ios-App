//
//  ViewController.swift
//  Pay4Date
//
//  Created by Ilham Malik Ibrahim on 7/22/16.
//  Copyright © 2016 kufed-ios. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    /* Variabel */
    let modelName = UIDevice.currentDevice().modelName
    /* End Variabel */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Controller FisrtController\n\n")
        // Do any additional setup after loading the view, typically from a nib.
        //Layout Iphone 4s
        
        
        //Layout Iphone 5
        
        
        //Layout Iphone 6
        
        
        //Layout Iphone 6plus
        
        
        
        //Layout Iphone 7
        
        
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn == 1) {
            self.performSegueWithIdentifier("home", sender: self)
        }
    }
    
    
    //layout iphone 4
    func iphone4(){
        print("Your Device is",modelName)
        
    }
    
    //layout iphone 5
    func iphone5(){
        
    }
    
    //layout iphone 6
    func iphone6(){
        
    }
    
    //layout iphone 6 plus
    func iphone6plus(){
        
    }
    
    //layout iphone
    func iphone(){
        [self .iphone4()]
        [self .iphone5()]
        [self .iphone6()]
        [self .iphone6plus()]
        
    }
    
    
}

