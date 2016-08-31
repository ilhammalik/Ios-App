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

class ProfileController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    /* Variabel */
    let modelName = UIDevice.currentDevice().modelName
    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    /* End Variabel */
    private let cellHeight: CGFloat = 210
    private let cellSpacing: CGFloat = 20
    private lazy var presentationAnimator = GuillotineTransitionAnimation()
    @IBOutlet var scrolView : UIScrollView!
    @IBOutlet var scrolGalery : UIScrollView!
    @IBOutlet var Name : UILabel!
    @IBOutlet var Age : UILabel!
    @IBOutlet var Gender : UILabel!
    @IBOutlet var Height : UILabel!
    @IBOutlet var Weight : UILabel!
    @IBOutlet var Description : UILabel!
    @IBOutlet var photo : UIImageView!
    @IBOutlet var viewApply : UIView!
    @IBOutlet var closeApply : UIButton!
    @IBOutlet var editProfile : UIButton!
    @IBOutlet var editView : UIView!
    @IBOutlet var editProfileScroll : UIScrollView!
    
    
    //edit Profile Field
    
    var data = ["male", "female"]
    var pickers = UIPickerView()
    
    
    @IBOutlet var firstNameProfile : UITextField!
    @IBOutlet var lastNameProfile : UITextField!
    @IBOutlet var genderProfile : UITextField!
    @IBOutlet var heightProfile : UITextField!
    @IBOutlet var weightProfile : UITextField!
    @IBOutlet var birthdayProfile : UITextField!
    @IBOutlet var descriptionProfile : UITextView!
    //end Profile
    
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Controller ProfileController\n")
        
        self.pickers.dataSource = self;
        self.pickers.delegate = self;
        
        getData()
        genderProfile.inputView = pickers
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        scrolView.scrollEnabled = true
        scrolView.contentSize = CGSizeMake(320, 400)
        
        scrolGalery.scrollEnabled = true
        scrolGalery.contentSize = CGSizeMake(1000, 50)
        //self.editView.hidden = true
        self.editProfileScroll.hidden = true
        navigationBar()
    }
    
    func navigationBar(){
        self.navigationItem.title = "Profile"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(back))
        
    }
    
    func back(sender: UIButton){
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func ViewLabel(){
        Name.text =  prefs.valueForKey("name") as? String
        Age.text =  prefs.valueForKey("age") as? String
        Gender.text =  prefs.valueForKey("gender") as? String
        Height.text =  prefs.valueForKey("height") as? String
        Weight.text =  prefs.valueForKey("weight") as? String
        Description.text =  prefs.valueForKey("description") as? String
        
        
    }
    
    func EditData (){
        firstNameProfile.text =  prefs.valueForKey("first_name") as? String
        lastNameProfile.text =  prefs.valueForKey("last_name") as? String
        genderProfile.text =  prefs.valueForKey("gender") as? String
        birthdayProfile.text =  prefs.valueForKey("birthday") as? String
        heightProfile.text =  prefs.valueForKey("height") as? String
        weightProfile.text =  prefs.valueForKey("weight") as? String
        descriptionProfile.text =  prefs.valueForKey("description") as? String
        
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
        
    }
    
    @IBAction func updateProfile(){
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let Token = prefs.valueForKey("token") as? String
        

        //parameters  Login from UI (User Interface Input)
        let firstname:NSString = firstNameProfile.text!
        let lastname:NSString = lastNameProfile.text!
        let height:NSString = heightProfile.text!
        let weight:NSString = weightProfile.text!
        let birthday:NSString = birthdayProfile.text!
        let gender:NSString = genderProfile.text!
        let description:NSString = descriptionProfile.text!
        
        
        let parametersRegister = [
            
            "name":"\(firstname)  \(lastname)",
            "first_name": firstname,
            "last_name": lastname,
            "height": height,
            "weight": weight,
            "birthday": birthday,
            "gender": gender,
            "description": description,
            ]
        
        let headersToken = [
            "appid": "4201620",
            "secretkey": SecretKey,
            "cache-control": CacheControl,
            "content-type": ContentType,
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json",
            "authtoken":String(Token!),
            ]

        
        Alamofire.request(.PUT, ApiProfileupdate,parameters:parametersRegister, headers: headersToken)
            .responseJSON { response in
                // result of response serialization
                if (response.response!.statusCode == 200 || response.response!.statusCode == 201 ) {
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = " Update Success"
                    alertView.message = "Success Thanks"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                    print(response.result.value)
                    self.editProfileScroll.hidden = true
                    self.editView.hidden = true
                    //clear textfiled after done
                    self.getData()
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        ViewLabel()
        EditData()
        getData()
    }
    
    //Calls this function when the tap is recognized.
    
    
    
    
    @IBAction func applyJob(sender: UIButton) {
        print("Function Apply Job")
        self.viewApply.hidden = false
        self.viewApply.layer.borderWidth = 3
        self.closeApply.hidden = false
        
        
    }
    
    @IBAction func closeJob(sender: UIButton) {
        print("Function Apply Job")
        //hide view
        self.viewApply.hidden = true
        self.closeApply.hidden = true
        
    }
    
    @IBAction func closeUpdateProfile(sender: UIButton) {
        print("Function Apply Job")
        //hide view
        self.editProfileScroll.hidden = true
        self.editView.hidden = true
    }
    
    @IBAction func doneProfile(sender: UIButton) {
        print("Function Apply Job Saving")
        
        self.editProfileScroll.hidden = false
        self.editView.hidden = false
        editProfileScroll.scrollEnabled = true
        editProfileScroll.contentSize = CGSizeMake(260, 700)
    }
    
    
    
    @IBAction func showMenuAction(sender: UIButton) {
        let menuVC = storyboard!.instantiateViewControllerWithIdentifier("MenuViewController")
        menuVC.modalPresentationStyle = .Custom
        menuVC.transitioningDelegate = self
        if menuVC is GuillotineAnimationDelegate {
            presentationAnimator.animationDelegate = menuVC as? GuillotineAnimationDelegate
        }
        presentationAnimator.supportView = self.navigationController?.navigationBar
        presentationAnimator.presentButton = sender
        presentationAnimator.duration = 0.6
        self.presentViewController(menuVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        firstNameProfile.resignFirstResponder()
        lastNameProfile.resignFirstResponder()
        heightProfile.resignFirstResponder()
        weightProfile.resignFirstResponder()
        birthdayProfile.resignFirstResponder()
        genderProfile.resignFirstResponder()
        descriptionProfile.resignFirstResponder()
        editProfileScroll.contentSize = CGSizeMake(260, 2000)
        return true
    }
    
    
    @IBAction func closeMenu(sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("home") as! HomeController
        
        // Creating a navigation controller with viewController at the root of the navigation stack.
        let navController = UINavigationController(rootViewController: viewController)
        self.presentViewController(navController, animated:true, completion: nil)
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func getData(){
        print("function get Data")
        
        
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
            .responseJSON { response in
                if  let result = response.result.value{
                    let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    Login.setObject(result["data"]!!["name"]!, forKey: "name")
                    Login.setObject(result["data"]!!["age"]!, forKey: "age")
                    Login.setObject(result["data"]!!["first_name"]!, forKey: "first_name")
                    Login.setObject(result["data"]!!["last_name"]!, forKey: "last_name")
                    Login.setObject(result["data"]!!["birthday"]!, forKey: "birthday")
                    Login.setObject(result["data"]!!["gender"]!, forKey: "gender")
                    Login.setObject(String(result["data"]!!["profile"]!!["height"]!!), forKey: "height")
                    Login.setObject(String(result["data"]!!["profile"]!!["weight"]!!), forKey: "weight")
                    Login.setObject(String(result["data"]!!["profile"]!!["description"]!!), forKey: "description")
                    Login.setObject(result["data"]!!["email"]!, forKey: "email")
                    Login.setObject(result["data"]!!["birthday"]!, forKey: "birthday")
                    Login.synchronize()
                }
        }
    }
    
    func textFieldDidBeginEditing(textfield :UITextField){
        let datePicker = UIDatePicker()
        textfield.inputView = datePicker
        datePicker.addTarget(self, action: #selector(ProfileController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let strDate = dateFormatter.stringFromDate(sender.date)
        // Finally we set the text of the label to our new string with the date
        birthdayProfile.text = strDate
        
    }
    

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderProfile.text = data[row]
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return data[row]
    }
    
}
extension ProfileController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .Presentation
        return presentationAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .Dismissal
        return presentationAnimator
    }
}


