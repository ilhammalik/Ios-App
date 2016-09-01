//
//  ViewController.swift
//  Pay4date
//
//  Created by kufed-ios on 7/25/16.
//  Copyright © 2016 Ilham Malik Ibrahim. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    let user = "david"
    let password = "framework"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request(.GET, "http://gemcave.pythonanywhere.com/api/order\(user)/\(password)")
            .authenticate(user: user, password: password)
            .responseJSON { response in
                debugPrint(response)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

