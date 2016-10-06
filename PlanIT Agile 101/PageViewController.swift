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
        page.sectionId = sectionId
        self.view.backgroundColor = UIColor.white
        
        loadItems()
        loadViews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadItems(){
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
                let querySQL = "SELECT itemid, sectionorder, type FROM items WHERE sectionid = \(sectionId) AND moduleid = \(moduleId);"
                let results:FMResultSet? = agileDB?.executeQuery(querySQL,
                                                                withArgumentsIn: nil)
                while results?.next() == true {
                    let itemid = Int(results!.int(forColumn: "itemid"))
                    let sectionorder = Int(results!.int(forColumn: "sectionorder"))
                    let type = String(results!.string(forColumn: "type"))
                    page.itemTypes[itemid] = type
                    page.sectionOrder[itemid] = sectionorder
                    page.itemids.append(itemid)
                }
                
                agileDB?.close()
            } else {
                print("Error: \(agileDB?.lastErrorMessage())")
            }
        }

    }
    
    func loadViews(){
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
