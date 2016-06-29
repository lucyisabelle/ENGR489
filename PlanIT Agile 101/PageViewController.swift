//
//  PageViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 28/06/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var sectionId = Int()
    var page = Page()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = "Hello"
        print("Section ID:")
        print(sectionId)
        page.sectionId = sectionId
  
        
        loadItems()
        //scrollView.addSubview(textView)
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
        
        var itemIds = [Int]()
        
        databasePath = dirPaths[0].URLByAppendingPathComponent("agileDB.db").path!
        
        print(databasePath)
        
        if filemgr.fileExistsAtPath(databasePath as String) {
            let agileDB = FMDatabase(path: databasePath as String)
            
            if agileDB == nil {
                print("Error: \(agileDB.lastErrorMessage())")
            }
            
            if agileDB.open() {
                let querySQL = "SELECT itemid FROM items WHERE sectionid = \(sectionId);"
                let results:FMResultSet? = agileDB.executeQuery(querySQL,
                                                                withArgumentsInArray: nil)
                while results?.next() == true {
                    itemIds.append(Int(results!.intForColumn("itemid")))
                }
                
                //page = Page(sectionId: sectionId)!
                
                for id in itemIds{
                    let query2SQL = "SELECT itemid, item FROM text WHERE itemid = \(id);"
                    let results2:FMResultSet? = agileDB.executeQuery(query2SQL, withArgumentsInArray: nil)
                    
                    while results2?.next() == true {
                        page.items += [results2!.stringForColumn("item")]
                    }
                }
                
                agileDB.close()
            } else {
                print("Error: \(agileDB.lastErrorMessage())")
            }
        }

    }
    
    func loadViews(){
        for item in page.items{
            let textView = UITextView(frame: self.view.frame)
            textView.text = item
            self.view.addSubview(textView)
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
