//
//  ResultsViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 3/10/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var moduleid = 1 //TODO: Fix this!
    var correctAnswers = Int()
    var incorrectAnswers = Int()

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resultLabel.text = "Correct Answers = \(correctAnswers) and Incorrect Answers = \(incorrectAnswers)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDatabase(){
        var databasePath = NSString()
        
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        
        databasePath = dirPaths[0].appendingPathComponent("agileDB.db").path as NSString
        
        //print(databasePath)
        
        
        if filemgr.fileExists(atPath: databasePath as String) {
            let agileDB = FMDatabase(path: databasePath as String)
            if agileDB == nil {
                print("Error: \(agileDB?.lastErrorMessage())")
            }
            
            if (agileDB?.open())!{
                let statementSQL = "UPDATE moduleprogress SET correct = \(correctAnswers), incorrect = \(incorrectAnswers) WHERE moduleid = \(moduleid)"
                agileDB?.executeUpdate(statementSQL, withArgumentsIn: nil)
            } else{
                print("Error: \(agileDB?.lastErrorMessage())")
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("Performing segue")
        updateDatabase()
    }

    
    

}
