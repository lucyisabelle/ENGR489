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
    @IBAction func LogInButton(_ sender: UIButton) {
        
        let text = EmailTextField.text!
        if text.lowercased().range(of: "@planit.co.nz") != nil {
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
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "segueTest" {
                if loginSuccess != true {
                    return false
                }
            }
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "segueTest") {
            let text = EmailTextField.text!
            if text.lowercased().range(of: "@planit.co.nz") != nil {
                print("Performing segue")
                let navController = segue.destination as! UINavigationController
                let detailController = navController.topViewController as! ModuleTableViewController
            
                var databasePath = NSString()
            
                let filemgr = FileManager.default
                let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
                
                databasePath = dirPaths[0].appendingPathComponent("agileDB.db").path as NSString
            
                detailController.toPass = databasePath
                //return true
            }
            
        }
    }

}

