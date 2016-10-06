//
//  Module.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 8/06/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class Module: NSObject{
    
    // MARK: Properties
    
    var moduleid : Int
    var modulename : String
    
    // MARK: Initialization
    
    init?(moduleid: Int, modulename: String) {
        //Initialise stored properties
        self.moduleid = moduleid
        self.modulename = modulename
        
        //Initialisation should fail if module name is empty or module id is not within 1 - 5
        if (modulename.isEmpty || moduleid < 1 || moduleid > 5){
            return nil
        }
    }
}
