//
//  ViewController.swift
//  Pay4Date
//
//  Created by Ilham Malik Ibrahim on 7/22/16.
//  Copyright © 2016 kufed-ios. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class SetPasswordController: UIViewController,BWWalkthroughViewControllerDelegate {
    /* Variabel */
    let modelName = UIDevice.currentDevice().modelName
    @IBOutlet var password : UITextField!
    @IBOutlet var cpassword : UITextField!

    var needWalkthrough:Bool = true
    var walkthrough:BWWalkthroughViewController!
    /* End Variabel */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Controller SetPasswordController\n")
        // Do any additional setup after loading the view, typically from a nib
        navigationBar()
  
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ForgetController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ForgetController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        // dismissKeyboard
        
    }
    
    func navigationBar(){
        self.navigationItem.title = "Forget Password"
        //        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(back))
        //
    }
    
    func back(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
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

    
    @IBAction func RequestPassword(){
        print("Reset Password")
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let reset = prefs.valueForKey("resetPassword") as? String
      
        let newPassword:NSString = password.text! as NSString
        let ConfirmPassword:NSString = cpassword.text! as NSString
        
        let headers = [
            "appid": AppId,
            "secretkey": SecretKey,
            "cache-control": CacheControl,
            "content-type": ContentType,
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json",
            ]
        print(String(reset!))
        let body = [
            "key": String(reset!),
            "newpassword": "\(newPassword)",
            "confirm_newpassword": "\(ConfirmPassword)",
            ]
        print("jk")
        Alamofire.request(.PUT, ApiSetPassword,parameters:body, headers: headers)
            .responseJSON { response in
                
                if (response.response!.statusCode == 200 || response.response!.statusCode < 201 ) {
                    if  let result = response.result.value as? [String : AnyObject]{
                        print("Reset Password Berhasil")

                        let vc = LoginController(nibName: "Login", bundle: nil)
                        var navb = UINavigationController(rootViewController: vc)
                        self.presentViewController(navb, animated:true, completion:nil)
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Reset Password in Success"
                        alertView.message = "Success Thanks"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()

                    }
                }else{
                    let result = response.result.value as? [String : AnyObject ]
                    print(result!["response"]!["message"]!)
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "\(result!["response"]!["description"]!)"
                    alertView.message = "\(result!["response"]!["message"]!)"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                    
                }
        }
        
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        
        if keyboardSize.height == offset.height {
            if self.view.frame.origin.y == 0 {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.view.frame.origin.y -= 130
                    print("key")
                    print(keyboardSize.height)
                })
            }
        } else {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height
            })
        }
        print(self.view.frame.origin.y)
    }
    
    
    func keyboardWillHide(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        self.view.frame.origin.y += 130
    }
    
    
}

extension SetPasswordController{
    
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


