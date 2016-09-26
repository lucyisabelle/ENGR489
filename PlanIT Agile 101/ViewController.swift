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
    var loginSuccess = false

    
    //MARK: Actions
    @IBAction func LogInButton(sender: UIButton) {
        
        let text = EmailTextField.text!
        if text.lowercaseString.rangeOfString("@planit.co.nz") != nil {
            print("exists")
            loginSuccess = true
            //performSegueWithIdentifier("segueTest", sender: self)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        self.EmailTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if let ident = identifier {
            if ident == "segueTest" {
                if loginSuccess != true {
                    return false
                }
            }
        }
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueTest") {
            let text = EmailTextField.text!
            if text.lowercaseString.rangeOfString("@planit.co.nz") != nil {
                print("Performing segue")
                let navController = segue.destinationViewController as! UINavigationController
                let detailController = navController.topViewController as! ModuleTableViewController
            
                var databasePath = NSString()
            
                let filemgr = NSFileManager.defaultManager()
                let dirPaths = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
                
                databasePath = dirPaths[0].URLByAppendingPathComponent("agileDB.db").path!
            
                detailController.toPass = databasePath
                //return true
            }
            
        }
    }

}

