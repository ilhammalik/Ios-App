//
//  ViewController.swift
//  youtube_demo4
//
//  Created by Brian Voong on 2/17/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Alamofire
import SwiftyJSON

class LoginController: UIViewController,BWWalkthroughViewControllerDelegate,UITextFieldDelegate,FBSDKLoginButtonDelegate   {
    
    //Variabel For delegate
    @IBOutlet var viewLogin : UIView!
    @IBOutlet var txtUsername : UITextField!
    @IBOutlet var txtPassword : UITextField!
    @IBOutlet var signButton : UIButton!
    @IBOutlet var birthday : UITextField!
    @IBOutlet var banner : UIImageView!
    var needWalkthrough:Bool = true
    var walkthrough:BWWalkthroughViewController!
    
    //End Variabel
    
    // configuration facebook
    let modelName = UIDevice.currentDevice().modelName
    var genderValue = 0
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFontOfSize(20)
        label.textAlignment = .Center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        // button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // End configuration facebook
    func navigationBar(){
        self.navigationItem.title = "Login"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(back))
        
    }
    
    func back(){
      self.tampil()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        navigationBar()
        CheckInternet().Check()

    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //keyboard
       CheckInternet()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        // dismissKeyboard
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        //end keyboard
        SessionFacebook()
        CheckInternet()
    }
    
       // LOGIN
    @IBAction func login(sender : UIButton) {
        let username:NSString = txtUsername.text!
        let password:NSString = txtPassword.text!
        
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            //parameters  Login from UI (User Interface Input)
            let parametersFacebook = [
                "username": "\(username)",
                "password": "\(password)",
                ]
            
            Alamofire.request(.POST, ApiLogin,parameters:parametersFacebook, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    if (response.response!.statusCode == 200 && response.response!.statusCode < 300 ) {
                        if  let result = response.result.value as? [String : AnyObject]{
                            print("cetak data yang berdasarkan POST dari Json")
                            let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                            Login.setObject(result["data"]!["account_token"]!, forKey: "token")
                            Login.setInteger(1, forKey: "ISLOGGEDIN")
                            Login.synchronize()
                            print("ini data",result["data"]!["email"]!)
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Sign in Success"
                            alertView.message = "Success Thanks"
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                            print(response.result.value)
                             print(String(Token!))
                            //redirect
                            //call controller storyboard from xib
                            let viewController:HomeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("home") as! HomeController
                            viewController.hidesBottomBarWhenPushed = true
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                        
                    } else {
                        // do something else
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in Failed!"
                        alertView.message = "Username / Password"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                     //
                    }
                    
                    
                    
            }
        }
    }
    
    @IBAction  func LoginFacebook(){
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: ""), forState: UIControlState.Normal)
        
        btnLeftMenu.frame = CGRectMake(0, 0, 50/2, 50/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
        //parameters  Facebook
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let Name = prefs.valueForKey("name") as? String
        let Firstname = prefs.valueForKey("firstname") as? String
        let Lastname = prefs.valueForKey("lastname") as? String
        let Email = prefs.valueForKey("email") as? String
        let Gender = prefs.valueForKey("gender") as? String
        let Birth = prefs.valueForKey("nbirthday") as? String
        let IDuser = prefs.valueForKey("userid") as? String
        let Social_access_token = prefs.valueForKey("token") as? String
        
        
        let parametersFacebook = [
            "social_id":"\(IDuser)",
            "name": String(Name!),
            "first_name": String(Firstname!),
            "last_name": String(Lastname!),
            "email": String(Email!),
            "birthday": String(Birth!),
            "gender": "\(Gender!)",
            "social_access_token": String(Social_access_token!),
            ]
        
        Alamofire.request(.POST, ApiLoginFacebook,parameters:parametersFacebook, headers: headers)
            .responseJSON { response in
                // result of response serialization
                
                if  let result = response.result.value as? [String : AnyObject]{
                    print("cetak data yang berdasarkan POST dari Json")
                    let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    Login.setObject(result["data"]!["social_access_token"]!, forKey: "token")
                    Login.setInteger(1, forKey: "ISLOGGEDIN")
                    Login.synchronize()
                    
                    
                    // print("JSON:",String(result["data"]!["email"]!))
                    
                    print(response.result.value)
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in With Facebook Success"
                    alertView.message = "Success Thanks"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                    //redirect
                    let loginPageView = self.storyboard?.instantiateViewControllerWithIdentifier("home") as! HomeController
                    loginPageView.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(loginPageView, animated: true)
                    
                }
                
        }
        
    }
    func setupSubviews() {
        view.addSubview(loginButton)
        loginButton.center =  CGPointMake(158, 187)
        view.addSubview(userImageView)
        view.addSubview(nameLabel)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": userImageView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[v0]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": loginButton]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[v0(100)]-8-[v1(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": userImageView, "v1": nameLabel, "v2": loginButton]))
        loginButton.delegate = self
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        //fetchProfile()
    }
    
    func fetchProfile() {
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler({ (connection, user, requestError) -> Void in
            
            if requestError != nil {
                print(requestError)
                return
            }
            
            var _ = user["email"] as? String
            let firstName = user["email"] as? String
            let lastName = user["email"] as? String
            
            self.nameLabel.text = "\(firstName!) \(lastName!)"
            
            var pictureUrl = ""
            
            if let picture = user["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                pictureUrl = url
            }
            
            let url = NSURL(string: pictureUrl)
            NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print(error)
                    return
                }
                
                let image = UIImage(data: data!)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.userImageView.image = image
                })
                
            }).resume()
            
            
        })
    }
    //delegate facebook
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        
        
        return true
    }
    
    //end delegate facebook
    

    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y = 250 - (40 + keyboardSize.height)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func textFieldDidBeginEditing(textfield :UITextField){
        let datePicker = UIDatePicker()
        textfield.inputView = datePicker
        datePicker.addTarget(self, action: #selector(LoginController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-dd-MM"
        let strDate = dateFormatter.stringFromDate(sender.date)
        // Finally we set the text of the label to our new string with the date
        birthday.text = strDate
        let NBirthday:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        NBirthday.setObject(String(strDate), forKey: "nbirthday")
        NBirthday.synchronize()
        
        let birth = NBirthday.valueForKey("nbirthday") as? String
        print("tanggal lahirku",String(birth!))
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        birthday.resignFirstResponder()
        
        return true
    }
    
    @IBAction func ContactUs(sender: UIButton) {
        let vc = ContactUsController(nibName: "ContactUs", bundle: nil)
        var navb = UINavigationController(rootViewController: vc)
        self.presentViewController(navb, animated:true, completion:nil)
        
    }
    
    @IBAction func ForgetPassword(sender: UIButton) {
        let vc = ForgetController(nibName: "ForgetPassword", bundle: nil)
        var navb = UINavigationController(rootViewController: vc)
        self.presentViewController(navb, animated:true, completion:nil)
        
    }
    

    
    func SessionFacebook(){
        //BEGIN GET TOKEN FB
        if let _ = FBSDKAccessToken.currentAccessToken() {
            //fetchProfile()
            
            let parameters = ["fields": "email,id, first_name, gender, last_name, picture.type(large)"]
            FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler({ (connection, user, requestError) -> Void in
                
                if requestError != nil {
                    print(requestError)
                    return
                }
                
                var _ = user["email"] as? String
                let firstName = user["email"] as? String
                let lastName = user["email"] as? String
                let email = user["email"] as? String
                let gender = user["gender"] as? String
                
                let userId = user["id"] as? String
                
                //akses token facebook
                let fbAccessToken = FBSDKAccessToken.currentAccessToken().tokenString
                self.nameLabel.text = "\(firstName!) \(lastName!)"
                NSLog("Login SUCCESS");
                print("token fb :",fbAccessToken)
                self.viewLogin.hidden = false
                self.loginButton.hidden = true
                self.nameLabel.hidden = true
                
                let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                let birth = Login.valueForKey("nbirthday") as? String
                Login.setObject("\(userId!)", forKey: "userid")
                Login.setObject("\(firstName!) \(lastName!)", forKey: "name")
                Login.setObject("\(firstName!)", forKey: "firstname")
                Login.setObject("\(lastName!)", forKey: "lastname")
                Login.setObject(email, forKey: "email")
                Login.setObject(gender, forKey: "gender")
                Login.setObject(fbAccessToken, forKey: "token")
                Login.setInteger(1, forKey: "ISLOGGEDIN")
                Login.synchronize()
                
                
                
            })
        }
        
        
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
    
    
//    func CheckInternet(){
//        if Reachability.isConnectedToNetwork() == true {
//            print("Internet connection OK")
//        } else {
//            print("Internet connection FAILED")
//            // Initialize Alert Controller
//            var alert = UIAlertController(title: "Cannot connect  to network", message: "Please check connection internet ", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "Go to Setting", style: .Default, handler: { (action: UIAlertAction!) in
//                print("Go to Setting")
//                UIApplication.sharedApplication().openURL(NSURL(string:"prefs:root=Setting")!)
//            }))
//            // Present Alert Controller
//            presentViewController(alert, animated: true, completion: nil)
//        }
//    }
}
extension LoginController{
    
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


