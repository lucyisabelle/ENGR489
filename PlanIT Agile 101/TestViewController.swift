//
//  TestViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 5/07/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var InnerView: UIView!
    var test = Test()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        test.loadQuestions()
        loadViews()
        //TODO: Update progress tracker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadViews(){
        label(0, y: 0, width: 300,height: 50, text: test.chunks[1]!)
        textField(0,  y: 50,  width: 300, height: 50, text: test.gaps[1]!)
    }
    
    func textField(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text : String){
        print("making text field")
        let textField = UITextField(frame: CGRectMake(x, y, width, height))
        textField.textAlignment = NSTextAlignment.Center
        textField.textColor = UIColor.blueColor()
        textField.borderStyle = UITextBorderStyle.Line
        textField.autocapitalizationType = UITextAutocapitalizationType.Words
        textField.text = text
        self.view.addSubview(textField)
    }
    
    func label(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text : String){
        print("making label")
        var label = UILabel(frame: CGRectMake(x, y, width, height))
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = text
        self.view.addSubview(label)
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
