//
//  Section.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 16/06/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class Section: NSObject{
    
    // MARK: Properties
    
    //TODO: var moduleid : Int
    var sectionname : String
    var sectionid : Int
    
    // MARK: Initialization
    
    init?(sectionid: Int, sectionname: String) {
        print("initialising section")
        //Initialise stored properties
        self.sectionid = sectionid
        self.sectionname = sectionname
        
        //Initialisation should fail if module name is empty or module id is not within 1 - 5
        if (sectionname.isEmpty || sectionid < 1){
            print("failed to create section")
            return nil
        }
    }
}
