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
    func trackModule(_ moduleId: Int) -> Int{
        self.updateProgress()
        if moduleId > 0 && moduleId < 7 {
            return Int(moduleProgress[moduleId]!)
        }
        else{
            return 0
        }
    }
    
    
    //connects to the progress table in the database and figures out the percentage complete of the given section
    func trackSection(_ sectionId: Int, moduleId: Int) -> Double {
        //connect to the database
        var databasePath = NSString()
        
        var percentageComplete = 0.0
        
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        
        databasePath = dirPaths[0].appendingPathComponent("agileDB.db").path as NSString
        
        
        if filemgr.fileExists(atPath: databasePath as String) {
            let agileDB = FMDatabase(path: databasePath as String)
            
            if agileDB == nil {
                print("Error: \(agileDB?.lastErrorMessage())")
            }
            if (agileDB?.open())!{
            
                let querySQL = "SELECT gapsComplete, totalGaps FROM progress WHERE moduleid = \(moduleId) AND sectionid = \(sectionId)"
                let results:FMResultSet? = agileDB?.executeQuery(querySQL,
                                                                withArgumentsIn: nil)
                while results?.next() == true {
                    let complete = Double(results!.int(forColumn: "gapsComplete"))
                    let total = Double(results!.int(forColumn: "totalGaps"))
                    percentageComplete = (complete/total)*100
                }
                agileDB?.close()
            }else {
                print("Error: \(agileDB?.lastErrorMessage())")
                return 0
            }
        }
            
        return percentageComplete
        
    }
    
    
    
    
    //connects to the database and updates the latest stats on progress. Remember only ever tracking progress within a module, not combined modules. Returns true if it successfully connected to the database, false otherwise.
    func updateProgress() -> Bool{
        
        var databasePath = NSString()
        
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        
        databasePath = dirPaths[0].appendingPathComponent("agileDB.db").path as NSString
        
        
        if filemgr.fileExists(atPath: databasePath as String) {
            let agileDB = FMDatabase(path: databasePath as String)
            
            if agileDB == nil {
                print("Error: \(agileDB?.lastErrorMessage())")
            }
            
            if (agileDB?.open())! {
                //here I need to query to progress table to check the latest progress. Maybe I could query for each module ID and have a map for each module id that maps to its progress. which would probably have to be calculated from the progress results.
                //let querySQL = "SELECT moduleid, modulename FROM MODULES;"
                //run through each module and run an sql statement chec
                for module in 1...6 {
                    //var sectionCount = 0.0
                    //var sectionCompleteCount = 0.0
                    var percentageComplete = 0
                    

                    var querySQL = "SELECT correct FROM moduleprogress WHERE moduleid = \(module);"
                    var results:FMResultSet? = agileDB?.executeQuery(querySQL, withArgumentsIn: nil)
                    
                    
                    var correctAnswers = 0
                    while results?.next() == true {
                        correctAnswers = Int(results!.int(forColumn: "correct"))
                    }
                    if correctAnswers != 0 {
                        percentageComplete = correctAnswers * 10
                    }
                    else {
                        percentageComplete = 0
                    }
                    //calculate the percentage complete
                    /*if (gapsComplete != 0){
                        let percentage = Double(Double(gapsComplete)/Double(totalGaps))
                        percentageComplete = Int(percentage * 100)
                        print("percentage = \(percentage) percentage complete = \(percentageComplete) gapsComplete = \(gapsComplete) totalGaps = \(totalGaps)")
                    }
                    else {
                        percentageComplete = 0
                    }*/
                    
                    //store the updated percentage in the dictionary. 
                    moduleProgress[module] = percentageComplete
                    //converting to radians will be the responsibility of the module view controller class.
                }
                agileDB?.close()
            } else {
                print("Error: \(agileDB?.lastErrorMessage())")
                return false
            }
            return true
        }
        return true
    }

}
