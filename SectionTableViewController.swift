//
//  SectionTableViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 16/06/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class SectionTableViewController: UITableViewController {

    // MARK: Properties
    
    @IBOutlet weak var returnButton: UIBarButtonItem!
    var sections = [Section]()
    var moduleId = Int()
    var sectionName = String()
    var moduleName = String()
    
    var progressTracker = ProgressTracker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.title = String(moduleId)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadSections()
        self.navigationItem.title = String(moduleName)
        
    }
    
    func loadSections(){
        
        var databasePath = NSString()
        
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        
        databasePath = dirPaths[0].appendingPathComponent("agileDB.db").path as NSString
        
        //print(databasePath)
        
        
        if filemgr.fileExists(atPath: databasePath as String) {
            //print("Got into filemanager stage")
            let agileDB = FMDatabase(path: databasePath as String)
            
            if agileDB == nil {
                print("Error: \(agileDB?.lastErrorMessage())")
            }
            
            if (agileDB?.open())! {
                //print("Got to open loop")
                let querySQL = "SELECT sectionname, sectionid, moduleid FROM SECTIONS WHERE moduleid = \(moduleId);" //TODO: WHERE moduleid = moduleid
                let results:FMResultSet? = agileDB?.executeQuery(querySQL,
                                                                withArgumentsIn: nil)
                while results?.next() == true {
                   // print("Got into results loop")
                    //print(results!.stringForColumn("sectionname"))
                   // print(results!.intForColumn("sectionid"))
                   // print(results!.intForColumn("moduleid"))
                    sectionName = String(results!.string(forColumn: "sectionname")!)
                    let section = Section(sectionid: Int(results!.int(forColumn: "sectionid")), sectionname: results!.string(forColumn: "sectionname"))!
                    sections += [section]
                    
                }
                
                agileDB?.close()
            } else {
                print("Error: \(agileDB?.lastErrorMessage())")
            }
        }
        
        
        //print("loading sections")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count 
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SectionTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SectionTableViewCell

        // Configure the cell...
        
        let section = sections[(indexPath as NSIndexPath).row]
        cell.sectionId = sections[(indexPath as NSIndexPath).row].sectionid
        cell.SectionNameLabel.text = String(section.sectionname)
        cell.progressView.percentageComplete = progressTracker.trackSection(sections[(indexPath as NSIndexPath).row].sectionid, moduleId: moduleId)
        
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

/*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       // performSegueWithIdentifier("GoToPageSegue", sender: self)
        let view = SectionPageViewController()
        self.presentViewController(view, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
*/
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        /*let navController = segue.destinationViewController as! UINavigationController
        let detailController = navController.topViewController as! PageViewController
        
        let indexPath = tableView.indexPathForSelectedRow;
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as! SectionTableViewCell!*/
        
        if (segue.identifier == "PageSegue") {
            var nextController = segue.destination as! PageViewController
            
            let indexPath = tableView.indexPathForSelectedRow;
            let currentCell = tableView.cellForRow(at: indexPath!) as! SectionTableViewCell!
        
            var sectionId = Int()
            sectionId = (currentCell?.sectionId)!   //sections[indexPath!.row].sectionid
            //print("Section id within prepare for segue is...")
            //print(sectionId)
            
        
            nextController.sectionId = sectionId
            nextController.moduleId = moduleId
        }
        
        if (segue.identifier == "testSegue"){
            var nextController = segue.destination as! TestViewController
            
            let indexPath = tableView.indexPathForSelectedRow;
            let currentCell = tableView.cellForRow(at: indexPath!) as! SectionTableViewCell!
            
            var sectionId = Int()
            sectionId = (currentCell?.sectionId)!   //sections[indexPath!.row].sectionid
            //print("Section id within prepare for segue is...")
            //print(sectionId)
            
            nextController.test.sectionID = sectionId
            nextController.test.moduleID = moduleId
        }
        

        
        /*if (segue.identifier == "goToMainMenu"){
            self.performSegueWithIdentifier("goToMainMenu", sender: self)
        }*/
        
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        
    }


}
