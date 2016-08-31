//
//  ViewController.swift
//  AlamofireWithSwiftyJSON
//
//  Created by MAC-186 on 4/12/16.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MessageUI
import CoreTelephony
class ContactUsController: UIViewController,MFMailComposeViewControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet var viewFeed: UIView!
    @IBOutlet var categori : UITextField!
    @IBOutlet var body : UITextView!
    
    var data = ["Payment System", "Referall Code","With Draw Proses","Forget Password"]
    var pickers = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar()
        self.pickers.dataSource = self;
        self.pickers.delegate = self;
        categori.inputView = pickers
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
        
    }
    
    @IBAction func Term(sender: UIButton){
        
        let vc = TermController(nibName: "Term", bundle: nil)
        var navb = UINavigationController(rootViewController: vc)
        self.presentViewController(navb, animated:true, completion:nil)
        
    }
    
    @IBAction func FAQ(sender: UIButton){
        
        let vc = FAQController(nibName: "FAQ", bundle: nil)
        var navb = UINavigationController(rootViewController: vc)
        self.presentViewController(navb, animated:true, completion:nil)
        
    }
    
    
    @IBAction func Email(sender: UIButton){
        
    }
    
    func navigationBar(){
        self.navigationItem.title = "Contact Us"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(back))
        
    }
    
    func back(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func showEmail(sender : UIButton){
        self.viewFeed.hidden = false
        print("Show Email")
        
    }
    
    
    @IBAction func sendEmail(sender: UIButton) {
        //Check to see the device can send email.
       
        if( MFMailComposeViewController.canSendMail() ) {
            print("Can send email.")
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            let modelName = UIDevice.currentDevice().modelName
            let networkInfo = CTTelephonyNetworkInfo()
            let carrier = networkInfo.subscriberCellularProvider
            // Get carrier name
            let carrierName = carrier!.carrierName
            //Set the subject and message of the email
            var emailTitle = categori.text
            var provider = String(carrierName!)
            var bodys = body.text
            var messageBody = "\(bodys)\n\n\n Device Version :\(modelName)\nProvider From : \(provider)"
            var toRecipents = ["ilham@kufed.com"]
            
            
            mailComposer.setSubject(emailTitle!)
            mailComposer.setMessageBody(messageBody, isHTML: false)
            mailComposer.setToRecipients(toRecipents)
            
            self.presentViewController(mailComposer, animated: true, completion: nil)
        }else{
            print("your email not yet set")
        }
            
    
    }
    
    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError?) {
        switch result {
        case MFMailComposeResultCancelled:
            print("Mail cancelled")
        case MFMailComposeResultSaved:
            print("Mail saved")
        case MFMailComposeResultSent:
            print("Mail sent")
        case MFMailComposeResultFailed:
            print("Mail sent failure: \(error!.localizedDescription)")
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categori.text = data[row]
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return data[row]
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        categori.resignFirstResponder()
        body.resignFirstResponder()
        
        return true
    }
    
    
}

