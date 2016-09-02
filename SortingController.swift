//
//  FAQController.swift
//  Pay4date
//
//  Created by kufed-ios on 8/15/16.
//  Copyright © 2016 Ilham Malik Ibrahim. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class SortingController: UIViewController{
    
    @IBOutlet var viewSort: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismiss")
        view.addGestureRecognizer(tap)
        
        viewSort.layer.borderWidth = 1
        viewSort.layer.masksToBounds = false
        viewSort.layer.borderColor = UIColor.clearColor().CGColor
        viewSort.layer.cornerRadius = 30
        viewSort.clipsToBounds = true
        
    }
  
    
    @IBAction func Term(sender: UIButton){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("term") as! HomeController
        let navigationController = UINavigationController(rootViewController: vc)
        self.presentViewController(navigationController, animated: true, completion: nil)
        
    }
    
    func dismiss() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

//
//    func getData(){
//        print("function get Data Refferal")
//        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
//        let Token = prefs.valueForKey("token") as? String
//        
//        let headersToken = [
//            "appid": "4201621",
//            "secretkey": SecretKey,
//            "cache-control": CacheControl,
//            "content-type": ContentType,
//            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
//            "Accept": "application/json",
//            "authtoken":String(Token!),
//            ]
//        
//        Alamofire.request(.GET, ApiFaq, headers: headersToken)
//            .responseJSON { response in
//                if  let result = response.result.value{
//                    let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
//                    print(result["data"])
//                    
//                    let swiftyJsonVar = JSON(response.result.value!)
//                    
//                    if let resData = swiftyJsonVar["data"].arrayObject {
//                        self.arrRes = resData as! [[String:AnyObject]]
//                        print("cetak faq")
//                        
//                        print(self.arrRes)
//                    }
//                    
//                    if self.arrRes.count > 0 {
//                        self.tableSegguest.reloadData()
//                    }
//                    
//                    
//                }
//        }
//    }
//    
    
}


