//
//  JobsDetailController.swift
//  Pay4date
//
//  Created by kufed-ios on 8/5/16.
//  Copyright © 2016 Ilham Malik Ibrahim. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import SwiftyJSON

class JobsDetailController: UIViewController {
    
    @IBOutlet var detailName : UILabel!
    @IBOutlet var dTitlePublish : UILabel!
    @IBOutlet var dMonth : UILabel!
    @IBOutlet var dDate : UILabel!
    @IBOutlet var dAddress : UILabel!
    @IBOutlet var dDesc : UILabel!
    @IBOutlet var dPrice : UITextView!
    
    @IBOutlet var scrolview : UIScrollView!
    var readName: String = ""
    var readTitle: String = ""
    var readMonth: String = ""
    var readDate: String = ""
    var readTime: String = ""
    var readAddress: String = ""
    var readDesc: String = ""
    var readPrice: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Controller JobDetailController\n\n")
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Jobs Detail"
        getLabel()
        
        scrolview.scrollEnabled = true
        scrolview.contentSize = CGSizeMake(300, 700)
        
    }
    
    func getLabel(){
        var month = readMonth.substringFromIndex(readMonth.startIndex.advancedBy(8)).substringToIndex(readMonth.startIndex.advancedBy(2))
        
        var dates = readMonth.substringFromIndex(readMonth.startIndex.advancedBy(5)).substringToIndex(readMonth.startIndex.advancedBy(2))
        
        detailName.text = readName
        dTitlePublish.text = readTitle
        dMonth.text = month
        dDate.text = dates
        dAddress.text = readAddress
        dPrice.text = readPrice
        //dDesc.text = readDesc
        
   
        
        
    }
    
}
    