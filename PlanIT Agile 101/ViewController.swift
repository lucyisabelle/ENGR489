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
    
    //MARK: Actions
    @IBAction func LogInButton(sender: UIButton) {
        if let text = EmailTextField.text {
            print(text)
            print(PasswordTextField.text)
        }
        
    }
    
    @IBAction func GoSignUpButton(sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        EmailTextField.delegate = self
        PasswordTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

