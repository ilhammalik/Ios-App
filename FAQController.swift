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

public enum TypeOfAccordianView {
    case Classic
    case Formal
}


class FAQController: UIViewController,UITableViewDataSource, UITableViewDelegate
{
    var typeOfAccordianView: TypeOfAccordianView? = .Formal
    @IBOutlet var tableSegguest : UITableView!
    var arrRes = [[String:AnyObject]]()
    var cellTapped:Bool = true
    var currentRow = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar()
        var nib = UINib(nibName: "FaqSuggest", bundle: nil)
        self.tableSegguest.registerNib(nib, forCellReuseIdentifier: "header")
        
        getData()
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCellWithIdentifier("header", forIndexPath: indexPath) as! SuggestCell
        
        var dict = arrRes[indexPath.row]
        cell.name?.text = dict["title"] as? String
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrRes.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

            return "Sugguest For You"

    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedRowIndex = indexPath
        currentRow = selectedRowIndex.row
        
        tableView.beginUpdates()
        tableView.endUpdates()
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
        
        Alamofire.request(.GET, ApiFaq, headers: headersToken)
            .responseJSON { response in
                if  let result = response.result.value{
                    let Login:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    print(result["data"])
                    
                    let swiftyJsonVar = JSON(response.result.value!)
                    
                    if let resData = swiftyJsonVar["data"].arrayObject {
                        self.arrRes = resData as! [[String:AnyObject]]
                        print("cetak faq")
                        
                        print(self.arrRes)
                    }
                    
                    if self.arrRes.count > 0 {
                        self.tableSegguest.reloadData()
                    }
                    
                    
                }
        }
    }
    
    
}


