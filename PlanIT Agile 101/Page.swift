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
        let screenSize: CGRect = UIScreen.main.bounds
        var ylocation = 0
        //go through section order and load each item as a subview
        for item in itemids {
            //retrieve the item from the database
            let text = self.retrieveText(item)
            //use a switch statement to figure out how the text should be displayed
            switch itemTypes[item]!{
            case  "bullet":
                //create a UI view that displays it as a bullet point
                let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
                let textView = UITextView(frame: smallFrame)
                //create first text view to find out the size it should be.
                textView.text = "• " + text
                textView.isEditable = false
                textView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
                textView.sizeToFit()
                let textheight = textView.contentSize.height
                
                //create second text view that's the correct size
                let finalFrame = CGRect(x:0, y:ylocation, width: Int(screenSize.width), height: Int(textheight))
                let textFinalView = UITextView(frame:finalFrame)
                textFinalView.text = "• " + text
                textFinalView.isEditable = false
                textFinalView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
                
                subViews.append(textFinalView)
                ylocation = ylocation + Int(textheight) + 10
                print(ylocation)
                print (textheight)
                
                
            case "heading":
                //create a UI view that displays it as a heading
                let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
                let textView = UITextView(frame: smallFrame)
                textView.text = text
                textView.isEditable = false
                textView.sizeToFit()
                
                textView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
                textView.sizeToFit()
                let textheight = textView.contentSize.height
                
                //create second text view that's the correct size
                let finalFrame = CGRect(x:0, y:ylocation, width: Int(screenSize.width), height: Int(textheight))
                let textFinalView = UITextView(frame:finalFrame)
                textFinalView.text = "• " + text
                textFinalView.isEditable = false
                textFinalView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
                
                subViews.append(textFinalView)
                ylocation = ylocation + Int(textheight) + 10
                
            case "text":
                //create a UI view that displays it as a bullet point
                let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
                let textView = UITextView(frame: smallFrame)
                textView.text = text
                textView.isEditable = false
                textView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
                textView.sizeToFit()
                
                let textheight = textView.contentSize.height
                
                //create second text view that's the correct size
                let finalFrame = CGRect(x:0, y:ylocation, width: Int(screenSize.width), height: Int(textheight))
                let textFinalView = UITextView(frame:finalFrame)
                
                //add text to the final view & set it's display properties
                textFinalView.text = text
                textFinalView.isEditable = false
                
                textFinalView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
                
                //add the view to the subviews array.
                subViews.append(textFinalView)
                ylocation = ylocation + Int(textheight) + 10
                
            case "quote":
                //create a UI view that displays it as a bullet point
                let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
                let textView = UITextView(frame: smallFrame)
                textView.text = text
                textView.isEditable = false
                textView.sizeToFit()
                subViews.append(textView)
                ylocation = ylocation + 100
                
            case "info":
                //create a UI view that displays it as a bullet point
                let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
                let textView = UITextView(frame: smallFrame)
                textView.text = text
                textView.isEditable = false
                textView.sizeToFit()
                subViews.append(textView)
                ylocation = ylocation + 100
                
            case "image":
                //retrieve the image from the assets photo and load it as a UIImageView
                let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
                let textView = UITextView(frame: smallFrame)
                textView.text = text
                textView.isEditable = false
                textView.sizeToFit()
                subViews.append(textView)
                ylocation = ylocation + 100
                
            default:
                //create a UI view that displays it as a bullet point
                let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
                let textView = UITextView(frame: smallFrame)
                textView.text = "DEFAULT"
                textView.isEditable = false
                textView.sizeToFit()
                subViews.append(textView)
                ylocation = ylocation + 100
            }
            
        }
    }
    
    func retrieveText(_ itemid: Int) -> String {
        //connect to the database and retrieve the text
        var returnedText = String()
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
                let querySQL = "SELECT item FROM text WHERE itemid = \(itemid);"
                let results:FMResultSet? = agileDB?.executeQuery(querySQL,
                                                                withArgumentsIn: nil)
                while results?.next() == true {
                    returnedText = results!.string(forColumn: "item");
                }
                
                agileDB?.close()
            } else {
                print("Error: \(agileDB?.lastErrorMessage())")
            }
        }
        return returnedText
    }
 
}
