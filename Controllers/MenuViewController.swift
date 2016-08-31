//
//  MenuViewController.swift
//  GuillotineMenuExample
//
//  Created by Maksym Lazebnyi on 10/8/15.
//  Copyright © 2015 Yalantis. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import FBSDKCoreKit



class MenuViewController: UIViewController, FBSDKLoginButtonDelegate, GuillotineMenu {
    //GuillotineMenu protocol
    var dismissButton: UIButton!
    var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button()
    }
    
    func button(){
        dismissButton = UIButton(frame: CGRectZero)
        dismissButton.setImage(UIImage(named: "ic_menu"), forState: .Normal)
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped(_:)), forControlEvents: .TouchUpInside)
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 1;
        titleLabel.text = "Pay4Date"
        titleLabel.font = UIFont.boldSystemFontOfSize(17)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        dismissButton.hidden = true
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("Menu: viewWillAppear")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("Menu: viewDidAppear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("Menu: viewWillDisappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("Menu: viewDidDisappear")
    }
    
    func dismissButtonTapped(sende: UIButton) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func menuButtonTapped(sender: UIButton) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func closeMenu(sender: UIButton) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func ContactUs(sender: UIButton) {
        let vc = ContactUsController(nibName: "ContactUs", bundle: nil)
        var navb = UINavigationController(rootViewController: vc)
        self.presentViewController(navb, animated:true, completion:nil)
        
    }
    
    @IBAction func logoutTapped(sender : UIButton) {
        print("Function Logout\n\n")
        
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        let vc = FirstController(nibName: "First", bundle: nil)
        self.presentViewController(vc, animated:true, completion:nil)
        
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    @IBAction func Profile(sender : UIButton) {
        let vc = ProfileController(nibName: "Profile", bundle: nil)
        var navb = UINavigationController(rootViewController: vc)
        self.presentViewController(navb, animated:true, completion:nil)
        
    }
    
    
    @IBAction func Refferal(sender : UIButton) {
        let vc = RefferalController(nibName: "Refferal", bundle: nil)
        var navb = UINavigationController(rootViewController: vc)
        self.presentViewController(navb, animated:true, completion:nil)
    }
    
    @IBAction func Reminder(sender: UIButton) {
        let vc = addReminderController(nibName: "Reminder", bundle: nil)
        var navb = UINavigationController(rootViewController: vc)
        self.presentViewController(navb, animated:true, completion:nil)
        
    }
    
    @IBAction func Test(sender : UIButton){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("faq") as! FAQViewController
        let navigationController = UINavigationController(rootViewController: vc)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
}

extension MenuViewController: GuillotineAnimationDelegate {
    func animatorDidFinishPresentation(animator: GuillotineTransitionAnimation) {
        print("menuDidFinishPresentation")
    }
    func animatorDidFinishDismissal(animator: GuillotineTransitionAnimation) {
        print("menuDidFinishDismissal")
    }
    
    func animatorWillStartPresentation(animator: GuillotineTransitionAnimation) {
        print("willStartPresentation")
    }
    
    func animatorWillStartDismissal(animator: GuillotineTransitionAnimation) {
        print("willStartDismissal")
    }
}