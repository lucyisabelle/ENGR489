//
//  ProgressTracker.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 7/08/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class ProgressTracker {
    
    var moduleProgress = [Int: Int]()
    
    init(){
        //initialise the moduleProgress dictionary.
        for module in 1...6 {
            moduleProgress[module] = 0
        }
        
        //run update progress for the first time. This will be called each time the app starts up, so it won't always be zero, apart from the very first time the app runs.
        self.updateProgress()
        
    }
    
    //the trackModule function gets sent the module ID and returns an integer value representing the percentage of the module that is complete. Will be used for drawing the progress circle on the homepage and the progress bar on the section view.
    func trackModule(moduleId: Int) -> Int{
        if moduleId > 0 && moduleId < 7 {
            return Int(moduleProgress[moduleId]!)
        }
        else{
            return 0
        }
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
                //run through each module and run an sql statement chec
                for module in 1...6 {
                    var sectionCount = 0.0
                    var sectionCompleteCount = 0.0
                    var percentageComplete = 0
                    
                    //figure out how many sections there are in each module
                    var querySQL = "SELECT COUNT(sectionid) AS COUNT FROM sections WHERE moduleid = \(module);"
                    var results:FMResultSet? = agileDB.executeQuery(querySQL,
                                                                    withArgumentsInArray: nil)
                    while results?.next() == true {
                        //figure out how many sections there are.
                        sectionCount = Double(results!.intForColumn("count"))
                    }
                    
                    //check how many sections have been completed
                    querySQL = "SELECT gapsComplete, totalGaps FROM progress WHERE moduleid = \(module);"
                    results = agileDB.executeQuery(querySQL, withArgumentsInArray: nil)
                    var gapsComplete = 0
                    var totalGaps = 0
                    while results?.next() == true {
                        //figure out how many sections are completed.
                        sectionCompleteCount = Double(results!.intForColumn("count"))
                        gapsComplete += Int(results!.intForColumn("gapsComplete"))
                        totalGaps += Int(results!.intForColumn(("totalGaps")))
                    }
                    
                    //calculate the percentage complete
                    if (sectionCompleteCount != 0){
                        percentageComplete = Int((gapsComplete / totalGaps) * 100)
                    }
                    else {
                        percentageComplete = 0
                    }
                    
                    //store the updated percentage in the dictionary. 
                    moduleProgress[module] = percentageComplete
                    
                    //converting to radians will be the responsibility of the module view controller class.
                }
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
