//
//  ProgressTracker.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 7/08/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class ProgressTracker {
    
    
    //the trackModule function gets sent the module ID and returns an integer value representing the percentage of the module that is complete. Will be used for drawing the progress circle on the homepage and the progress bar on the section view.
    func trackModule(moduleId: Int) -> Int{
     return 0
    }
    
    
    //connects to the database and updates the latest stats on progress. Remember only ever tracking progress within a module, not combined modules. Returns true if it successfully connected to the database, false otherwise.
    func updateProgress() -> Bool{
        
        var databasePath = NSString()
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        databasePath = dirPaths[0].URLByAppendingPathComponent("agileDB.db").path!
        
        print(databasePath)
        
        
        if filemgr.fileExistsAtPath(databasePath as String) {
            let agileDB = FMDatabase(path: databasePath as String)
            
            if agileDB == nil {
                print("Error: \(agileDB.lastErrorMessage())")
            }
            
            if agileDB.open() {
                //here I need to query to progress table to check the latest progress. Maybe I could query for each module ID and have a map for each module id that maps to its progress. which would probably have to be calculated from the progress results.
                //let querySQL = "SELECT moduleid, modulename FROM MODULES;"
                
                agileDB.close()
            } else {
                print("Error: \(agileDB.lastErrorMessage())")
                return false
            }
            return true
        }
        return true
    }

}
