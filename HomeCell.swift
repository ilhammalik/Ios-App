//
//  HomeCell.swift
//  Pay4date
//
//  Created by kufed-ios on 8/4/16.
//  Copyright © 2016 Ilham Malik Ibrahim. All rights reserved.
//

import Foundation

import UIKit

class HomeCell: UITableViewCell {
    
    /* Views */
    @IBOutlet var id: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var gender: UILabel!
    @IBOutlet var photo: UIImageView!
    @IBOutlet var addToFavOutlet: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
