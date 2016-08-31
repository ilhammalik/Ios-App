//
//  TabOpen.swift
//  Pay4date
//
//  Created by kufed-ios on 8/31/16.
//  Copyright © 2016 Ilham Malik Ibrahim. All rights reserved.
//

import Foundation
//Xcode 6 Beta 6
import UIKit
//NOTE: Solution 1
class TabClose: UIViewController {
    
    @IBOutlet var viewEdit: UIView!
    @IBOutlet var viewPlus: UIView!
    @IBOutlet var viewSearch: UIView!
    
    /* NOTE: Solution 2
     required init(coder aDecoder: NSCoder) {
     super.init(nibName: "TestViewController", bundle: NSBundle.mainBundle())
     }
     */
    
    //NOTE: Solution 3
    //Name the xib module.viewcontroller.xib -> TestXibStoryBoard.TestViewController.xib
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layout(){
        self.viewEdit.layer.cornerRadius = self.viewEdit.frame.height/2
        self.viewPlus.layer.cornerRadius = self.viewPlus.frame.height/2
        self.viewSearch.layer.cornerRadius = self.viewSearch.frame.height/2
        
    }
    @IBAction func tabOpen(sender: AnyObject) {
        print("Function open Tab")
        let vc = TabOpenController(nibName: "tabOpen", bundle: nil)
        self.presentViewController(vc, animated:true, completion:nil)
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
