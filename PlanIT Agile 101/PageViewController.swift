//
//  PageViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 28/06/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    var sectionId = Int()
    var moduleId = Int()
    var page = Page()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //hard coding in section id for now, as it is causing thread issues TODO: Fix this.
        print("this page view controller thinks it's sectionid is: \(sectionId)")
        page.sectionId = sectionId
        self.view.backgroundColor = UIColor.whiteColor()
        
        loadItems()
        loadViews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadItems(){
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
                let querySQL = "SELECT itemid, sectionorder, type FROM items WHERE sectionid = \(sectionId) AND moduleid = \(moduleId);"
                print(querySQL)
                let results:FMResultSet? = agileDB.executeQuery(querySQL,
                                                                withArgumentsInArray: nil)
                while results?.next() == true {
                    let itemid = Int(results!.intForColumn("itemid"))
                    let sectionorder = Int(results!.intForColumn("sectionorder"))
                    let type = String(results!.stringForColumn("type"))
                    page.itemTypes[itemid] = type
                    page.sectionOrder[itemid] = sectionorder
                    page.itemids.append(itemid)
                }
                
                agileDB.close()
            } else {
                print("Error: \(agileDB.lastErrorMessage())")
            }
        }

    }
    
    func loadViews(){
        /**let screenSize: CGRect = UIScreen.mainScreen().bounds
        var ylocation = 10
        for item in page.items{
            let smallFrame = CGRect(x: 0, y: ylocation, width: Int(screenSize.width), height: 100)
            let textView = UITextView(frame: smallFrame)
            textView.text = item
            textView.editable = false
            textView.sizeToFit()
            self.view.addSubview(textView)
            ylocation = ylocation + 100 //does this need to be reset to the size of the resized text view? **/
        page.createSubViews()
        for view in page.subViews {
            self.view.addSubview(view);
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
