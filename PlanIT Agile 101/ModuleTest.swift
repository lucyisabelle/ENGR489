//
//  ModuleTest.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 19/09/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class ModuleTest {
    var views = [UIViewController]()
    
    func loadViews(moduleid: Int) {
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
            
            if agileDB.open(){
                //connect to the database and grab all the questions
                //first connect to multi table
                var querySQL = "SELECT a, b, c, d, answer, questionorder FROM multi WHERE moduleid = \(moduleid)"
                var results = agileDB.executeQuery(querySQL, withArgumentsInArray: nil)
                
                //create viewcontrollers for each question
                while results?.next() == true {
                    
                }
                
                
                //then connect to truefalse table
                querySQL = "SELECT a,b,answer,questionorder FROM multi WHERE moduleid = \(moduleid)"
                results = agileDB.executeQuery(querySQL, withArgumentsInArray: nil)
                
                //create view controllers for each question
                while results?.next() == true {
                    
                }
                
                agileDB.close()
            } else {
                print("Error: \(agileDB.lastErrorMessage())")
            }
        }
    }
}
