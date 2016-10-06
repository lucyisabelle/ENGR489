//
//  Test.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 28/08/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class Test {
    
    var sectionID = 1
    var moduleID = 1
    var chunks = [Int: String]()
    var gaps = [Int: String]()
    var questionsAnswered = [Int:Bool]()
    
    func loadQuestions(){
        var databasePath = NSString()
        
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        
        
        databasePath = dirPaths[0].appendingPathComponent("agileDB.db").path as NSString
        
        print(databasePath)
        
        if filemgr.fileExists(atPath: databasePath as String) {
            let agileDB = FMDatabase(path: databasePath as String)
            
            if agileDB == nil {
                print("Error: \(agileDB?.lastErrorMessage())")
            }
            
            if (agileDB?.open())! {
                //remember to update this so that the section ID isn't hardcoded.
                
                //connect to the chunks table
                //create dictionary of section order to chunk
                var querySQL = "SELECT sectionorder, chunk FROM chunk WHERE moduleid = \(moduleID) AND sectionid = \(sectionID);"
                var results:FMResultSet? = agileDB?.executeQuery(querySQL,
                                                                withArgumentsIn: nil)
                while results?.next() == true {
                    let sectionOrder = Int(results!.int(forColumn: "sectionorder"))
                    let chunk = results!.string(forColumn: "chunk")
                    chunks[sectionOrder] = chunk
                }
                //connect to gaps table
                //create dictionary of section order to gap
                querySQL = "SELECT sectionorder, gap FROM gap WHERE moduleid = 1 AND sectionid = 1;"
                results = agileDB?.executeQuery(querySQL, withArgumentsIn: nil)
                
                while results?.next() == true {
                    let sectionOrder = Int(results!.int(forColumn: "sectionorder"))
                    let gap = results!.string(forColumn: "gap")
                    gaps[sectionOrder] = gap
                }
                
                
                agileDB?.close()
            } else {
                print("Error: \(agileDB?.lastErrorMessage())")
            }
        }
    }
    
    func updateProgress(){
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
                var gapsComplete = 0
                let totalGaps = gaps.keys.count
                for (gap, answer) in questionsAnswered {
                    if answer == true {
                        gapsComplete += 1
                    }
                }
                let statementSQL = "UPDATE progress SET gapsComplete = \(gapsComplete), totalGaps = \(totalGaps) WHERE sectionid = \(sectionID) AND moduleid = \(moduleID)"
                agileDB?.executeUpdate(statementSQL, withArgumentsIn: nil)
            
            } else {
                print("Error: \(agileDB?.lastErrorMessage())")
            }
        }
    }
}
