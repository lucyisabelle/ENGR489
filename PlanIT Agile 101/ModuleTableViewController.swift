//
//  ModuleTableViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 8/06/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class ModuleTableViewController: UITableViewController {
    
    // MARK: Properties

    var modules = [Module]()
    var toPass:NSString!
    var moduleId = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadModules()
    }
    
    func loadModules(){
        
        var databasePath = NSString()
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        databasePath = dirPaths[0].URLByAppendingPathComponent("agileDB.db").path!
        
        print(databasePath)
        
        
        if filemgr.fileExistsAtPath(databasePath as String) {
            print("Got into filemanager stage")
            let agileDB = FMDatabase(path: databasePath as String)
            
            if agileDB == nil {
                print("Error: \(agileDB.lastErrorMessage())")
            }
            
            if agileDB.open() {
                print("Got to open loop")
                let querySQL = "SELECT moduleid, modulename FROM MODULES;"
                let results:FMResultSet? = agileDB.executeQuery(querySQL,
                                                                  withArgumentsInArray: nil)
                while results?.next() == true {
                    print("Got into results loop")
                    print(results!.stringForColumn("modulename"))
                    print(results!.intForColumn("moduleid"))
                    let module = Module(moduleid: Int(results!.intForColumn("moduleid")), modulename: results!.stringForColumn("modulename"))!
                    modules += [module]
                    
                }
                
                agileDB.close()
            } else {
                print("Error: \(agileDB.lastErrorMessage())")
            }
        }

        
        print("loading modules")
        let module1 = Module(moduleid: 1, modulename: "Introduction to Agile Methods")!
        modules += [module1]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modules.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let cellIdentifier = "ModuleTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ModuleTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let module = modules[indexPath.row]
        
        // Configure the cell...
        cell.NameLabel.text = String(module.modulename)
        print(module.moduleid)
        cell.IdLabel.text = String(module.moduleid)
        print(cell.IdLabel.text)
        
        //return cell
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "sectionSegue") {
            let navController = segue.destinationViewController as! UINavigationController
            let detailController = navController.topViewController as! SectionTableViewController
            
            let indexPath = tableView.indexPathForSelectedRow;
            let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as! ModuleTableViewCell!;
            
            moduleId = Int(currentCell.IdLabel.text!)!
            print(moduleId)
            
            detailController.moduleId = moduleId
        }
    }

    

}
