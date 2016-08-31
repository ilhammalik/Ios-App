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

class TermController: UIViewController {
    
   @IBOutlet var titleTerm : UILabel!
   @IBOutlet var desc : UITextView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar()
        getData()
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        self.titleTerm.text = prefs.valueForKey("titleTerm") as? String
        self.desc.text = prefs.valueForKey("contentTerm") as? String
        
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        getData()
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        self.titleTerm.text = prefs.valueForKey("titleTerm") as? String
        self.desc.text = prefs.valueForKey("contentTerm") as? String
        

        
    }
    
    func navigationBar(){
        self.navigationItem.title = "TERMS & CONDITIONS"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(back))
    }
    
    func back(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func Term(sender: UIButton){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("term") as! HomeController
        let navigationController = UINavigationController(rootViewController: vc)
        self.presentViewController(navigationController, animated: true, completion: nil)
        
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
                    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    self.titleTerm.text = prefs.valueForKey("titleTerm") as? String
                    self.desc.text = prefs.valueForKey("contentTerm") as? String

                    print(response)
            }
        }
    }
    

    
}
