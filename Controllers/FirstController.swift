//
//  ViewController.swift
//  Pay4Date
//
//  Created by Ilham Malik Ibrahim on 7/22/16.
//  Copyright © 2016 kufed-ios. All rights reserved.
//

import UIKit



class FirstController: UIViewController,BWWalkthroughViewControllerDelegate {
    /* Variabel */
    var needWalkthrough:Bool = true
    var walkthrough:BWWalkthroughViewController!
    
    /* End Variabel */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Controller FisrtController\n\n")
        
    
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
           presentWalkthrough()
            
    }
    
    @IBAction func presentWalkthrough(){
        
        let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
        walkthrough = stb.instantiateViewControllerWithIdentifier("container") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewControllerWithIdentifier("page_1")
        let page_two = stb.instantiateViewControllerWithIdentifier("page_2")
        let page_three = stb.instantiateViewControllerWithIdentifier("page_3")
       
        // Attach the pages to the master
        walkthrough.delegate = self
        walkthrough.addViewController(page_one)
        walkthrough.addViewController(page_two)
        walkthrough.addViewController(page_three)

        self.presentViewController(walkthrough, animated: true) {
            ()->() in
            self.needWalkthrough = false
        }
    }
    
}


extension FirstController{
    
    func walkthroughCloseButtonPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func walkthroughPageDidChange(pageNumber: Int) {
        if (self.walkthrough.numberOfPages - 1) == pageNumber{
            self.walkthrough.closeButton?.hidden = false
        }else{
            self.walkthrough.closeButton?.hidden = true
        }
    }
    
}
