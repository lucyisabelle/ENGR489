//
//  Test.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 28/08/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class Test {
    
    let sectionID = 1
    let moduleID = 1
    var chunks = [Int: String]()
    var gaps = [Int: String]()
    var questionsAnswered = [Int:Bool]()
    
    func loadQuestions(){
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
                //remember to update this so that the section ID isn't hardcoded.
                
                //connect to the chunks table
                //create dictionary of section order to chunk
                var querySQL = "SELECT sectionorder, chunk FROM chunk WHERE moduleid = 1 AND sectionid = 1;"
                var results:FMResultSet? = agileDB.executeQuery(querySQL,
                                                                withArgumentsInArray: nil)
                while results?.next() == true {
                    let sectionOrder = Int(results!.intForColumn("sectionorder"))
                    let chunk = results!.stringForColumn("chunk")
                    chunks[sectionOrder] = chunk
                }
                //connect to gaps table
                //create dictionary of section order to gap
                querySQL = "SELECT sectionorder, gap FROM gap WHERE moduleid = 1 AND sectionid = 1;"
                results = agileDB.executeQuery(querySQL, withArgumentsInArray: nil)
                
                while results?.next() == true {
                    let sectionOrder = Int(results!.intForColumn("sectionorder"))
                    let gap = results!.stringForColumn("gap")
                    gaps[sectionOrder] = gap
                }
                
                
                agileDB.close()
            } else {
                print("Error: \(agileDB.lastErrorMessage())")
            }
        }
    }
    
    func updateProgress(){
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
                var gapsComplete = 0
                let totalGaps = gaps.keys.count
                for (gap, answer) in questionsAnswered {
                    if answer == true {
                        gapsComplete += 1
                    }
                }
                let statementSQL = "UPDATE progress SET gapsComplete = \(gapsComplete), totalGaps = \(totalGaps) WHERE sectionid = \(sectionID) AND moduleid = \(moduleID)"
                agileDB.executeUpdate(statementSQL, withArgumentsInArray: nil)
            
            } else {
                print("Error: \(agileDB.lastErrorMessage())")
            }
        }
    }
}