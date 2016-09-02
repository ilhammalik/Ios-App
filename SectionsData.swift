//
//  SectionsData.swift
//  sections
//
//  Created by Dan Beaulieu on 9/11/15.
//  Copyright © 2015 Dan Beaulieu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SectionsData {
    
    let url = ApiFaq;
    //let url = "https://api.myjson.com/bins/3nuvn";
    
    var myArray: [AnyObject] = []
    var arrRes = [[String:AnyObject]]()
    var child: Array<String>?
    
    func getSectionsFromData(completion: ([Sections]? -> Void)){
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let Token = prefs.valueForKey("token") as? String
        
        
        
        var sectionsArray = [Sections]()
        
        let animals = [Sections]()
        
        
        let headersToken = [
            "appid": "4201620",
            "secretkey": SecretKey,
            "cache-control": CacheControl,
            "content-type": ContentType,
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json",
            "authtoken":String(Token!),
            ]
        
        Alamofire.request(.GET, ApiFaq, headers:headersToken, encoding: .JSON)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        
                        let swiftyJsonVar = JSON(response.result.value!)
                        
                        for (key, subJson) in swiftyJsonVar["data"] {
                            let title = subJson["title"].string
                            let child = subJson["title"].string
                           
                            for (_, data) in subJson {
                                for (title, objects) in data {
                                    let titles = subJson["title"].string
                                    
                                    //sectionsArray.append(Sections(title: titles!, objects: objects.self.arrayValue.map { $0.string!}))
                                    sectionsArray.append(Sections(title: titles!, objects: ["MacBook", "MacBook Air", "MacBook Pro", "iMac"]))
                                   
                                }

                                
                            }
                            
                            
                           
                            
                        }
                                                
                        
                       
                        
                        
                        //
//                        if let resData = swiftyJsonVar["data"].arrayObject {
//                            self.arrRes = resData as! [[String:AnyObject]]
//                            print("hkjhkh")
//                            let child = resData["children"]!["title"] as? String
//                            print(child)
//                            
//                        }
                        
                        
                    }
                    //sectionsArray.append(animals)
                    completion(sectionsArray)
                case .Failure(let error):
                    print(error)
                    //  sectionsArray.append(animals)
                    completion(nil)
                }
                
                
        }
        
        
    }
}