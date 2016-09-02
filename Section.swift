//
//  Section.swift
//  sections
//
//  Created by Dan Beaulieu on 9/11/15.
//  Copyright © 2015 Dan Beaulieu. All rights reserved.
//

import Foundation

struct Sections {
    
    var name : String
    var items : [String]
    var collapsed: Bool!
    var child: Array<String>?
    
    init(title: String, objects: [String], collapsed: Bool = false) {
        self.name = title
        self.items = objects
        self.collapsed = collapsed
    }
    
}