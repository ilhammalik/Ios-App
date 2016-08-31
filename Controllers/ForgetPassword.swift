//
//  ViewController.swift
//  Pay4Date
//
//  Created by Ilham Malik Ibrahim on 7/22/16.
//  Copyright © 2016 kufed-ios. All rights reserved.
//

import UIKit

class ForgetController: UIViewController {
    /* Variabel */
    let modelName = UIDevice.currentDevice().modelName
    /* End Variabel */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Controller ForgetController\n")
        // Do any additional setup after loading the view, typically from a nib
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        navigationBar()
        
    }
    
    func navigationBar(){
        self.navigationItem.title = "Forget Password"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(back))
        
    }
    
    func back(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // Cancel
    @IBAction func cancel(sender: AnyObject) {
        print("Function CancelFacebook\n\n")
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
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
    
    func CheckInternet(){
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

