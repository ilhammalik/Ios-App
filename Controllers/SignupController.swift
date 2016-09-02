//
//  ViewController.swift
//  Pay4Date
//
//  Created by Ilham Malik Ibrahim on 7/22/16.
//  Copyright © 2016 kufed-ios. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit
import MobileCoreServices
import Alamofire

class SignupController: UIViewController,UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, FBSDKLoginButtonDelegate,UIPickerViewDataSource, UIPickerViewDelegate  {
    
    /* Variabel */
    //cheklist grey
    
    
    @IBOutlet var ch : UIImageView!
    @IBOutlet var ch2 : UIImageView!
    @IBOutlet var ch3 : UIImageView!
    @IBOutlet var ch4 : UIImageView!
    @IBOutlet var ch5 : UIImageView!
    @IBOutlet var ch6 : UIImageView!
    @IBOutlet var ch7 : UIImageView!
    @IBOutlet var ch8 : UIImageView!
    @IBOutlet var ch9 : UIImageView!
    
    
    //end checklist
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var firstname : UITextField!
    @IBOutlet var lastname : UITextField!
    @IBOutlet var username : UITextField!
    @IBOutlet var email : UITextField!
    @IBOutlet var password : UITextField!
    @IBOutlet var height : UITextField!
    @IBOutlet var weight : UITextField!
    @IBOutlet var birthday : UITextField!
    @IBOutlet var gender : UITextField!
    @IBOutlet var code : UITextField!
    @IBOutlet weak var next : UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var scrolView : UIScrollView!
    
    
    var data = ["male", "female"]
    var pickers = UIPickerView()
    
    
    
    var imagePicker: UIImagePickerController!
    
    let modelName = UIDevice.currentDevice().modelName
    
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
    
    
    /* End Variabel */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Controller SignUpController\n\n")
        //Check Connection
        self.pickers.dataSource = self;
        self.pickers.delegate = self;
        
        gender.inputView = pickers
        
        self.logo.layer.cornerRadius = self.logo.frame.height/2
        self.logo.layer.borderWidth = 5
        self.logo.layer.masksToBounds = true
        self.logo.layer.borderColor = UIColor.purpleColor().CGColor
        // Do any additional setup after loading the view, typically from a nib.
        
        //Layout Iphone 4s
        [self .iphone()]
        //end iphone 4
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        // dismissKeyboard
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        setupSubviews()
        
        
        // navgitaion title
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        
        //button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        // end navigation title
        
        // scroll
        scrolView.scrollEnabled = true
        // Do any additional setup after loading the view
        scrolView.contentSize = CGSizeMake(320, 1400)
        // scroll
        navigationBar()
        
    }
    
    func navigationBar(){
        self.navigationItem.title = "Register"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(back))
        
    }
    
    func back(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
        
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
        let birth = prefs.valueForKey("nbirthday") as? String
        let IDuser = prefs.valueForKey("userid") as? String
        let Social_access_token = prefs.valueForKey("token") as? String
        
        
        let parametersFacebook = [
            "social_id":"\(IDuser)",
            "name": String(Name!),
            "first_name": String(Firstname!),
            "last_name": String(Lastname!),
            "email": String(Email!),
            "birthday":String(birth!),
            "gender": "\(Gender!)",
            "social_access_token": String(Social_access_token!),
            ]
        
        Alamofire.request(.POST, ApiLoginFacebook,parameters:parametersFacebook, headers: headers)
            .responseJSON { response in
                // result of response serialization
                
                if  let result = response.result.value as? [String : AnyObject]{
                    print("cetak data yang berdasarkan POST dari Json")
                    let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    let birth = Login.valueForKey("nbirthday") as? String
                    Login.setObject(result["data"]!["social_access_token"]!, forKey: "token")
                    Login.setObject(result["data"]!["first_name"]!, forKey: "firstname")
                    Login.setObject(result["data"]!["last_name"]!, forKey: "lastname")
                    Login.setObject(result["data"]!["name"]!, forKey: "name")
                    Login.setObject(result["data"]!["email"]!, forKey: "email")
                    Login.setObject(result["data"]!["social_id"]!, forKey: "socialId")
                    
                    Login.setObject(result["data"]!["birthday"]!, forKey: "birthday")
                    Login.setObject(result["data"]!["gender"]!, forKey: "gender")
                    
                    Login.setInteger(1, forKey: "ISLOGGEDIN")
                    Login.synchronize()
                    // print("tanggal lahirku",result["data"]!["birthday"]!)
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
    
    
    
    @IBAction func signupTapped(sender : UIButton) {
        let Firstname:NSString = firstname.text! as NSString
        let Lastname:NSString = lastname.text! as NSString
        let Username:NSString = username.text! as NSString
        let Password:NSString = password.text! as NSString
        let Email:NSString = email.text! as NSString
        let Height:NSString = height.text! as NSString
        let Weight:NSString = weight.text! as NSString
        let Birthday:NSString = birthday.text! as NSString
        let Gender:NSString = gender.text! as NSString
        let Code:NSString = code.text! as NSString
        
        
        if (Firstname.isEqualToString("")) {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Nama"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if ( Lastname.isEqualToString("")) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Nama"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if (Email.isEqualToString("")) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Email"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if (Password.isEqualToString("")) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if (Height.isEqualToString("")) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Height"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if (Weight.isEqualToString("")) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Weight "
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if (Birthday.isEqualToString("")) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Birtday"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if (Birthday.isEqualToString("")) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Gender"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            //parameters  Login from UI (User Interface Input)
            print("sukses signup")
            
            let parametersRegister = [
                "name":  Firstname,
                "first_name": Firstname,
                "last_name": Lastname,
                "username": Username,
                "password": Password,
                "email": Email,
                "height": Height,
                "weight": Weight,
                "birthday": Birthday,
                "gender": Gender,
                "referral_code": Code,
                ]

            let headers = [
                "appid": AppId,
                "secretkey": SecretKey,
                "cache-control": CacheControl,
                "content-type": ContentType,
                "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                "Accept": "application/json",
                ]
            
            Alamofire.request(.POST, ApiRegister, parameters:parametersRegister, headers: headers)
                .responseJSON { response in
                    // result of response serialization
                    if (response.response!.statusCode == 200 || response.response!.statusCode == 201 ) {
                        
                        let result = response.result.value as? [String : AnyObject]
                        print("cetak data yang berdasarkan POST dari Json")
                        let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        Login.setObject(result!["data"]!["name"]!, forKey: "name")
                        Login.setObject(result!["data"]!["username"]!, forKey: "username")
                        Login.setObject(result!["data"]!["first_name"]!, forKey: "firstname")
                        Login.setObject(result!["data"]!["last_name"]!, forKey: "lastname")
                        Login.setObject(result!["data"]!["password"]!, forKey: "lastname")
                        Login.setObject(result!["data"]!["email"]!, forKey: "email")
                        Login.setObject(result!["data"]!["height"]!, forKey: "height")
                        Login.setObject(result!["data"]!["weight"]!, forKey: "weight")
                        Login.setObject(result!["data"]!["birthday"]!, forKey: "birthday")
                        Login.setObject(result!["data"]!["gender"]!, forKey: "gender")
                        Login.setObject(result!["data"]!["activation"]!["key"], forKey: "key")
                        Login.synchronize()
                        
                        let vc = UploadPhotoController(nibName: "UploadPhoto", bundle: nil)
                        self.presentViewController(vc, animated:true, completion:nil)
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Signup Success"
                        alertView.message = "Success Thanks"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                        print(response.result.value)
                        
                        
                    }
                    else {
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
        
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        
        let scrollView: UIView = UIView(frame: CGRectMake(0, 0, 400, 2300))
        SessionFacebook()
        
    }
    
    @IBAction func Check(){
        self.loginButton.hidden = true
        if(firstname.text!.isEmpty){
            ch.image = UIImage(named: "checkgrey.png")
            
        }else{
            ch.image = UIImage(named: "checkgreen.png")
        }
        if(lastname.text!.isEmpty){
            ch2.image = UIImage(named: "checkgrey.png")
            
        }else{
            ch2.image = UIImage(named: "checkgreen.png")
        }
        if(username.text!.isEmpty){
            ch3.image = UIImage(named: "checkgrey.png")
            
        }else{
            ch3.image = UIImage(named: "checkgreen.png")
        }
        if(email.text!.isEmpty){
            ch4.image = UIImage(named: "checkgrey.png")
            
        }else{
            ch4.image = UIImage(named: "checkgreen.png")
        }
        
        if(password.text!.isEmpty){
            ch5.image = UIImage(named: "checkgrey.png")
            
        }else{
            ch5.image = UIImage(named: "checkgreen.png")
        }
        
        if(height.text!.isEmpty){
            ch6.image = UIImage(named: "checkgrey.png")
            
        }else{
            ch6.image = UIImage(named: "checkgreen.png")
        }
        
        if(weight.text!.isEmpty){
            ch7.image = UIImage(named: "checkgrey.png")
            
        }else{
            ch7.image = UIImage(named: "checkgreen.png")
        }
        
        if(birthday.text!.isEmpty){
            ch8.image = UIImage(named: "checkgrey.png")
            
        }else{
            ch8.image = UIImage(named: "checkgreen.png")
        }
        
        if(gender.text!.isEmpty){
            ch9.image = UIImage(named: "checkgrey.png")
            
        }else{
            ch9.image = UIImage(named: "checkgreen.png")
        }
        
        
        
    }
    
    func setupSubviews() {
        view.addSubview(loginButton)
        loginButton.center =  CGPointMake(158, 228)
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
            let firstName = user["first_name"] as? String
            let lastName = user["last_name"] as? String
            
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
    
    /* untuk akses protocol Controller Facebook */
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    /* End untuk akses protocol Controller Facebook */
    
    
    
    
    func SessionFacebook(){
        //BEGIN GET TOKEN FB
        if let _ = FBSDKAccessToken.currentAccessToken() {
            //fetchProfile()
            
            let parameters = ["fields": "email, id, first_name, gender, last_name, picture.type(large)"]
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
    
    func textFieldDidBeginEditing(textfield :UITextField){
        let datePicker = UIDatePicker()
        textfield.inputView = datePicker
        datePicker.addTarget(self, action: #selector(SignupController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let strDate = dateFormatter.stringFromDate(sender.date)
        // Finally we set the text of the label to our new string with the date
        birthday.text = strDate
//        birthday2.text = strDate
        print(strDate)
    
        let NBirthday:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        NBirthday.setObject(String(strDate), forKey: "nbirthday")
        NBirthday.synchronize()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        birthday.resignFirstResponder()
        
        return true
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text = data[row]
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return data[row]
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
