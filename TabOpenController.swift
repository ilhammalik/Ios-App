//
//  TabOpen.swift
//  Pay4date
//
//  Created by kufed-ios on 8/31/16.
//  Copyright © 2016 Ilham Malik Ibrahim. All rights reserved.
//

import Foundation
import UIKit
//Xcode 6 Beta 6
//NOTE: Solution 1
class TabOpenController: UIViewController {
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view4: UIView!
    @IBOutlet var view5: UIView!
    @IBOutlet var view6: UIView!
    /* NOTE: Solution 2
     required init(coder aDecoder: NSCoder) {
     super.init(nibName: "TestViewController", bundle: NSBundle.mainBundle())
     }
     */
    
    //NOTE: Solution 3
    //Name the xib module.viewcontroller.xib -> TestXibStoryBoard.TestViewController.xib
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view1.layer.cornerRadius = self.view1.frame.height/2
        self.view2.layer.cornerRadius = self.view2.frame.height/2
        self.view3.layer.cornerRadius = self.view3.frame.height/2
        self.view4.layer.cornerRadius = self.view4.frame.height/2
        self.view5.layer.cornerRadius = self.view5.frame.height/2
        self.view6.layer.cornerRadius = self.view6.frame.height/2
        
        // Do any additional setup after loading the view.
    }
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tabClose(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)

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
