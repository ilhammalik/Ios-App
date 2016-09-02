//
//  HomeController.swift
//  Pay4Date
//
//  Created by Ilham Malik Ibrahim on 7/22/16.
//  Copyright © 2016 kufed-ios. All rights reserved.
//


import UIKit

class HomeController: UIViewController {
     /* Variabel */
    let modelName = UIDevice.currentDevice().modelName
    @IBOutlet var usernameLabel : UILabel!
    @IBOutlet var homeView: UIView!
    @IBOutlet var PlusviewOpen: UIView!
    @IBOutlet var PlusviewHide: UIView!
    @IBOutlet var menuButtonOpen: UIButton!
    @IBOutlet var menuButtonHide: UIButton!
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    @IBOutlet var menuviewOpen: UIView!
    /* End Variabel */

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Controller HomeController\n\n")
        // Do any additional setup after loading the view.
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "icon-plus.png"), forState: UIControlState.Normal)
        btnLeftMenu.addTarget(self, action: "menuClose", forControlEvents: UIControlEvents.TouchUpInside)
        btnLeftMenu.frame = CGRectMake(0, 0, 50/2, 50/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton

        
        //Layout Iphone 4s
        
        
        //Layout Iphone 5
        
        
        //Layout Iphone 6
        
        
        //Layout Iphone 6plus
        
        
        
        //Layout Iphone 7
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.homeView.hidden = true
            self.performSegueWithIdentifier("goto_login", sender: self)
        } else {
            
            self.homeView.hidden = false
            self.PlusviewOpen.hidden = false
            self.PlusviewHide.hidden = true
            
            
            //self.usernameLabel.text = prefs.valueForKey("PASSWORD") as? String
        }
        
    }
    
    
    @IBAction func logoutTapped(sender : UIButton) {
        print("Function Logout\n\n")

        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        self.performSegueWithIdentifier("goto_login", sender: self)
    }
    
    @IBAction func open(sender: AnyObject) {
        print("Function open")
        self.PlusviewOpen.hidden = true
        self.PlusviewHide.hidden = false
    }
    @IBAction func close(sender: AnyObject) {
        print("Function close")
        self.PlusviewOpen.hidden = false
        self.PlusviewHide.hidden = true
    }
    

    func menuOpen(){
        self.menuviewOpen.hidden = false
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "icon-edit.png"), forState: UIControlState.Normal)
        btnLeftMenu.addTarget(self, action: "menuClose", forControlEvents: UIControlEvents.TouchUpInside)
        btnLeftMenu.frame = CGRectMake(0, 0, 50/2, 50/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    
    func menuClose(){
        print("Function close")
        self.menuviewOpen.hidden = true
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "icon-plus.png"), forState: UIControlState.Normal)
        btnLeftMenu.addTarget(self, action: "menuOpen", forControlEvents: UIControlEvents.TouchUpInside)
        btnLeftMenu.frame = CGRectMake(0, 0, 50/2, 50/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
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
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    
}