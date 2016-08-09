//
//  TestViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 5/07/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var ALabel: UIButton!
    @IBOutlet weak var BLabel: UIButton!
    @IBOutlet weak var CLabel: UIButton!
    @IBOutlet weak var DLabel: UIButton!
    var answer: String?

  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadQuestions()
        let progressTracker = ProgressTracker()
        progressTracker.updateProgress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadQuestions(){
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
                //remember to update this so that the section ID isn't hardcoded.
                let querySQL = "SELECT question, a, b, c, d, answer FROM test WHERE sectionid = 11;"
                let results:FMResultSet? = agileDB.executeQuery(querySQL,
                                                                withArgumentsInArray: nil)
                while results?.next() == true {
                    questionLabel.text = results?.stringForColumn("question")
                    ALabel.setTitle(results?.stringForColumn("a"), forState: .Normal)
                    ALabel.titleLabel?.numberOfLines = 0
                    ALabel.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
                    
                    BLabel.setTitle(results?.stringForColumn("b"), forState: .Normal)
                    CLabel.setTitle(results?.stringForColumn("c"), forState: .Normal)
                    DLabel.setTitle(results?.stringForColumn("d"), forState: .Normal)
                    
                    self.answer = results?.stringForColumn("answer")
                    
                }
                
                
                agileDB.close()
            } else {
                print("Error: \(agileDB.lastErrorMessage())")
            }
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
