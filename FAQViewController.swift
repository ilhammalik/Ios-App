//
//  SectionsTableViewController.swift
//  sections
//
//  Created by Dan Beaulieu on 9/11/15.
//  Copyright © 2015 Dan Beaulieu. All rights reserved.
//

import UIKit
import UIKit
import Alamofire
import SwiftyJSON

extension UIView {
    func rotate(toValue: CGFloat, duration: CFTimeInterval = 0.2, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.toValue = toValue
        rotateAnimation.duration = duration
        rotateAnimation.removedOnCompletion = false
        rotateAnimation.fillMode = kCAFillModeForwards
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}

class FAQViewController: UIViewController,UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate,UITableViewDelegate {
    
    
    @IBOutlet var dataTable : UITableView!
    @IBOutlet var cari : UISearchBar!
    var sections: [Sections] = []
    var arrRes = [[String:AnyObject]]()
    var _currentIndexPath:NSIndexPath?

    
    //var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SectionsData().getSectionsFromData({ sectionsArray in
            self.sections = sectionsArray!
            //reload your table with sectionsArray
            print("ini data \n")
            print(self.sections,"\n")
            print(self.sections.count)
            self.dataTable.reloadData()
        })
     
        navigationBar()
  
    }
    
    func navigationBar(){
       self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(back))
    }
    
    func back(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //
    // MARK: - Table view delegate
    //
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sections[section].collapsed!) ? 0 : sections[section].items.count
    }
    
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("header") as! HeaderCell
        
        header.toggleButton.tag = section
        header.titleLabel.text = sections[section].name
        header.toggleButton.rotate(sections[section].collapsed! ? 0.0 : CGFloat(M_PI_2))
        header.toggleButton.addTarget(self, action: #selector(FAQViewController.toggleCollapse), forControlEvents: .TouchUpInside)
        
        return header.contentView
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        
        return cell
    }
    
    //
    // MARK: - Event Handlers
    //
    func toggle(sender: UIButton) {
        let section = sender.tag
        let collapsed = sections[section].collapsed
        print(collapsed)
        // Toggle collapse
        sections[section].collapsed = true
        
        // Reload section
        dataTable.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
    }
    
    func toggleCollapse(sender: UIButton) {
        let section = sender.tag
        let collapsed = sections[section].collapsed
        print(collapsed)
        // Toggle collapse
        sections[section].collapsed = !collapsed
        
        // Reload section
        dataTable.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
    }

}
