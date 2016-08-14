//
//  Page.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 28/06/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class Page: NSObject {
    
    var items = [String]()
    var sectionId = Int()
    var subViews = [UIView] ()
    var itemids = [Int]()
    
    //dictionary that maps item id's to their type
    var itemTypes = [Int: String]()
    //dictionary that maps item id's to their ordering within the section 
    var sectionOrder = [Int:Int]()
    
    //this class will create all the subviews and store them in an array that can be accessed by the view controller.
    func createSubViews(){
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        var ylocation = 10
        //go through section order and load each item as a subview
        for item in itemids {
            //first check that item type isn't image
            if itemTypes[item]! != "image" {
                //retrieve the item from the database
                var text = self.retrieveText(item)
                //use a switch statement to figure out how the text should be displayed
                switch itemTypes[item]!{
                    case  "bullet":
                        //create a UI view that displays it as a bullet point
                        let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
                        let textView = UITextView(frame: smallFrame)
                        textView.text = text
                        textView.editable = false
                        textView.sizeToFit()
                        subViews.append(textView)
                        ylocation = ylocation + 100
                    
                    case "heading":
                        //create a UI view that displays it as a heading
                        let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
                        let textView = UITextView(frame: smallFrame)
                        textView.text = text
                        textView.editable = false
                        textView.sizeToFit()
                        subViews.append(textView)
                        ylocation = ylocation + 100
                    
                    case "text":
                        //create a UI view that displays it as a bullet point
                        let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
                        let textView = UITextView(frame: smallFrame)
                        textView.text = text
                        textView.editable = false
                        textView.sizeToFit()
                        subViews.append(textView)
                        ylocation = ylocation + 100
                    
                    case "quote":
                        //create a UI view that displays it as a bullet point
                        let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
                        let textView = UITextView(frame: smallFrame)
                        textView.text = text
                        textView.editable = false
                        textView.sizeToFit()
                        subViews.append(textView)
                        ylocation = ylocation + 100
                    
                    case "info":
                        //create a UI view that displays it as a bullet point
                        let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
                        let textView = UITextView(frame: smallFrame)
                        textView.text = text
                        textView.editable = false
                        textView.sizeToFit()
                        subViews.append(textView)
                        ylocation = ylocation + 100
                    
                    default:
                        //create a UI view that displays it as a bullet point
                        let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
                        let textView = UITextView(frame: smallFrame)
                        textView.text = "DEFAULT"
                        textView.editable = false
                        textView.sizeToFit()
                        subViews.append(textView)
                        ylocation = ylocation + 100
                }
                
            }
            //if it is, it has to get the item from the image table
            
        }
    }
    
    func retrieveText(itemid: Int) -> String {
        //connect to the database and retrieve the text
        var returnedText = String()
        var databasePath = NSString()
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        databasePath = dirPaths[0].URLByAppendingPathComponent("agileDB.db").path!
        if filemgr.fileExistsAtPath(databasePath as String) {
            let agileDB = FMDatabase(path: databasePath as String)
            
            if agileDB == nil {
                print("Error: \(agileDB.lastErrorMessage())")
            }
            
            if agileDB.open() {
                let querySQL = "SELECT item FROM text WHERE itemid = \(itemid);"
                let results:FMResultSet? = agileDB.executeQuery(querySQL,
                                                                withArgumentsInArray: nil)
                while results?.next() == true {
                    returnedText = results!.stringForColumn("item");
                }
                
                agileDB.close()
            } else {
                print("Error: \(agileDB.lastErrorMessage())")
            }
        }
        return returnedText
    }
 /**
 
 //page = Page(sectionId: sectionId)!
 //TODO Move this stuff to the page class.
 for id in itemIds{
 let query2SQL = "SELECT itemid, item FROM text WHERE itemid = \(id);"
 let results2:FMResultSet? = agileDB.executeQuery(query2SQL, withArgumentsInArray: nil)
 
 while results2?.next() == true {
 page.items += [results2!.stringForColumn("item")]
 }
 **/ 
 
}