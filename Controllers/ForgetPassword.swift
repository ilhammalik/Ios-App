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

class ForgetController: UIViewController,BWWalkthroughViewControllerDelegate {
    /* Variabel */
    let modelName = UIDevice.currentDevice().modelName
    @IBOutlet var request : UIButton!
    @IBOutlet var email : UITextField!
    @IBOutlet var viewInfo: UIView!
    @IBOutlet var viewInfo2: UIView!
    var needWalkthrough:Bool = true
    var walkthrough:BWWalkthroughViewController!
    /* End Variabel */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Controller ForgetController\n")
        // Do any additional setup after loading the view, typically from a nib
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        navigationBar()
        
        request.layer.borderWidth = 1
        request.layer.masksToBounds = true
        request.layer.borderColor = UIColor.blueColor().CGColor
        request.layer.cornerRadius = 15
        request.clipsToBounds = true
        
        viewInfo.layer.borderWidth = 1
        viewInfo.layer.masksToBounds = false
        viewInfo.layer.borderColor = UIColor.clearColor().CGColor
        viewInfo.layer.cornerRadius = 30
        viewInfo.clipsToBounds = true
        
        viewInfo2.layer.borderWidth = 1
        viewInfo2.layer.masksToBounds = false
        viewInfo2.layer.borderColor = UIColor.clearColor().CGColor
        viewInfo2.layer.cornerRadius = 17
        viewInfo2.clipsToBounds = true
        
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
    
   @IBAction func RequestPassword(){
         print("Reset Password")
            let Email:NSString = email.text! as NSString
            let headers = [
                "appid": AppId,
                "secretkey": SecretKey,
                "cache-control": CacheControl,
                "content-type": ContentType,
                "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                "Accept": "application/json",
                ]
            
            let body = [
                "email": "\(Email)",
                ]
            
            Alamofire.request(.POST, ApiForgetPassword,parameters:body, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in

                    if (response.response!.statusCode == 200 || response.response!.statusCode < 201 ) {
                        if  let result = response.result.value as? [String : AnyObject]{
                            print("Reset Password Berhasil")
                            
                            print(result)
                            self.tampil()
                            let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                            Login.setObject(result["data"]!["token"]!, forKey: "resetPassword")
                            Login.synchronize()
                            
                        }else{
                            let result = response.result.value as? [String : AnyObject ]
                            print(result!["response"]!["message"]!)
                        }
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
                    self.view.frame.origin.y -= 200
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
        self.view.frame.origin.y += 200
    }
    
    
}

extension ForgetController{
    
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


