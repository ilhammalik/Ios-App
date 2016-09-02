//
//  TermController.swift
//  Pay4date
//
//  Created by kufed-ios on 8/15/16.
//  Copyright © 2016 Ilham Malik Ibrahim. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper
import SwiftyJSON
import RealmSwift

class createJobController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var scrollView : UIScrollView!
    @IBOutlet var gender : UITextField!
    
    var data = ["Male", "Female"]
    var pickers = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar()
        getData()
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSizeMake(400, 2500)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(createJobController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.pickers.dataSource = self;
        self.pickers.delegate = self;
        
        gender.inputView = pickers
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        getData()
   
        
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

    
    func navigationBar(){
        self.navigationItem.title = "Add Job"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(back))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(back))
    }
    
    func back(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    

    func getData(){
        
        let headersToken = [
            "appid": "4201620",
            "secretkey": SecretKey,
            "cache-control": CacheControl,
            "content-type": ContentType,
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json",
            
            ]
        
        Alamofire.request(.GET, ApiTerm, headers: headersToken)
            .responseJSON { response in
                if  let result = response.result.value{
                    let Term:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    Term.setObject(result["data"]!!["title"]!, forKey: "titleTerm")
                    Term.setObject(result["data"]!!["content"]!, forKey: "contentTerm")
                    Term.synchronize()
                    print("print data Api Term")

                    print(response)
                }
        }
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
    
}
