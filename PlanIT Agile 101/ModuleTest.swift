//
//  ModuleTest.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 19/09/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class ModuleTest {
    
    //true if it's a multi choice question, false otherwise.
    var questions = [Question]()
    
    func getQuestion(index : Int) -> Question{
        print("get question at index: \(index)")
        return questions[index]
    }
    
    func loadViews(moduleid: Int)  {
        var databasePath = NSString()
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        for number in 0...10 {
            let questionTest = Question(multichoice: false, a: "test", b: "test", c: "test", d: "test", answer: "test", questionString: "test")
            questions.insert(questionTest, atIndex: number)
        }
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
                var querySQL = "SELECT a, b, c, d, answer, questionorder, question FROM multi WHERE moduleid = \(moduleid)"
                var results = agileDB.executeQuery(querySQL, withArgumentsInArray: nil)
                
                //store all the values for each question
                while results?.next() == true {
                    let a = results!.stringForColumn("a")
                    let b = results!.stringForColumn("b")
                    let c = results!.stringForColumn("c")
                    let d = results!.stringForColumn("d")
                    let answer = results!.stringForColumn("answer")
                    let questionorder = Int(results!.intForColumn("questionorder"))
                    let questionString = results!.stringForColumn("question")
                    
                    let question = Question(multichoice: true, a: a, b: b, c: c, d: d, answer: answer, questionString: questionString)
                    print("question order = \(questionorder)")
                    questions[questionorder] = question
                    //questions.insert(question, atIndex: questionorder)
                }
                
                
                //then connect to truefalse table
                querySQL = "SELECT a,b,answer,questionorder, question FROM truefalse WHERE moduleid = \(moduleid)"
                results = agileDB.executeQuery(querySQL, withArgumentsInArray: nil)
                
                //create view controllers for each question
                while results?.next() == true {
                    let a = results!.stringForColumn("a")
                    let b = results!.stringForColumn("b")
                    let answer = results!.stringForColumn("answer")
                    let questionorder = Int(results!.intForColumn("questionorder"))
                    let questionString = results!.stringForColumn("question")
                    
                    let question = Question(multichoice: false, a : a, b: b, c: "", d: "", answer: answer, questionString: questionString)
                    
                    questions[questionorder] = question 
                }
                
                agileDB.close()
            } else {
                print("Error: \(agileDB.lastErrorMessage())")
            }
            
            //var viewController = MultichoiceViewController
        }
    }
}
