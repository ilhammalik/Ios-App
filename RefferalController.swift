//
//  RefferalController.swift
//  Pay4date
//
//  Created by kufed-ios on 8/22/16.
//  Copyright © 2016 Ilham Malik Ibrahim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RefferalController: UIViewController{
    
    @IBOutlet var photo : UIImageView!
    @IBOutlet var name : UIImageView!
    @IBOutlet var code : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Controller RefferalController\n")
        navigationBar()
        self.photo.layer.cornerRadius = self.photo.frame.height/2
        getData()
    }
    
    func navigationBar(){
        self.navigationItem.title = "Your Refferal"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(back))
        
    }
    
    func back(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareSheet(sender: UIButton) {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let Code = prefs.valueForKey("rcode") as? String
        
        let textToShare = String(Code!)
        
        let objectsToShare = [textToShare]
        let applicationActivities = [FavoriteActivity()]
        
        let avc = UIActivityViewController(activityItems: objectsToShare, applicationActivities: applicationActivities)
        
        self.presentViewController(avc, animated: true, completion: nil)
    }
    
    func getData(){
        print("function get Data Refferal")
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let Token = prefs.valueForKey("token") as? String
        
        let headersToken = [
            "appid": "4201621",
            "secretkey": SecretKey,
            "cache-control": CacheControl,
            "content-type": ContentType,
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json",
            "authtoken":String(Token!),
            ]
        
        Alamofire.request(.GET, ApiReferralMy, headers: headersToken)
            .responseJSON { response in
                if  let result = response.result.value{
                    let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    print(result["data"])
                    Login.setObject(result["data"]!!["referral_code"]!, forKey: "rcode")
                    Login.synchronize()
                    
                    let Code = Login.valueForKey("rcode") as? String
                    self.code.text = String(Code!)
                }
        }
    }
    
}

class FavoriteActivity: UIActivity {
    override func activityType() -> String? {
        return "TestActionss.Favorite"
    }
    
    override func activityTitle() -> String? {
        return "Add to Favorites"
    }
    
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        NSLog("%@", __FUNCTION__)
        return true
    }
    
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        NSLog("%@", __FUNCTION__)
    }
    
    override func activityViewController() -> UIViewController? {
        NSLog("%@", __FUNCTION__)
        return nil
    }
    
    override func performActivity() {
        // Todo: handle action:
        NSLog("%@", __FUNCTION__)
        
        self.activityDidFinish(true)
    }
    
    override func activityImage() -> UIImage? {
        return UIImage(named: "favorites_action")
    }
}