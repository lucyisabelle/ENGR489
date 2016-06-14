//
//  ViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 19/05/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    var textField = "Hello"
    
    //MARK: Actions
    @IBAction func LogInButton(sender: UIButton) {
        if let text = EmailTextField.text {
            print(text)
            print(PasswordTextField.text)
        }
        
    }
    
    @IBAction func GoSignUpButton(sender: UIButton) {
    }
    
    var databasePath = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        EmailTextField.delegate = self
        PasswordTextField.delegate = self
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        databasePath = dirPaths[0].URLByAppendingPathComponent("agileDB.db").path!
        
        print(databasePath)
        
        
        if !filemgr.fileExistsAtPath(databasePath as String) {
            print("Got into original filemgr")
            let agileDB = FMDatabase(path: databasePath as String)
            
            if agileDB == nil {
                print("Error: \(agileDB.lastErrorMessage())")
            }
            
            if agileDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS USERS (EMAIL CHAR(50) PRIMARY KEY NOT NULL, PASSWORD CHAR(20) NOT NULL);"
                if !agileDB.executeStatements(sql_stmt) {
                    print("Error: \(agileDB.lastErrorMessage())")
                }
                agileDB.close()
            } else {
                print("Error: \(agileDB.lastErrorMessage())")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueTest") {
            let navController = segue.destinationViewController as! UINavigationController
            let detailController = navController.topViewController as! ModuleTableViewController
            
            
            //var svc = segue!.destinationViewController as! ModuleTableViewController;
            
            detailController.toPass = databasePath
            
        }
    }

}

