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

class LoginFacebook: UIViewController {
    
    @IBOutlet var titleTerm : UILabel!
    @IBOutlet var desc : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        self.titleTerm.text = prefs.valueForKey("titleTerm") as? String
        self.desc.text = prefs.valueForKey("contentTerm") as? String
        
        
    }
    
    
    
}
