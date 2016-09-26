//
//  MultichoiceViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 12/09/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class MultichoiceViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    var a = String()
    var b = String()
    var c = String()
    var d = String()
    var question = String()
    var answer = String()
    
    var moduleid = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buttonA.setTitle("hello", forState: UIControlState.Normal)
        setLabels()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func initiate() -> MultichoiceViewController {
        return UIStoryboard(name : "Main", bundle: nil).instantiateViewControllerWithIdentifier("MultichoiceViewController") as! MultichoiceViewController
    }
    
    func test() {
        print("Test function")
        //buttonA.setTitle("Test", forState: UIControlState.Normal)
    }
    
    func setValues(question: Question){
        self.a = question.optionA
        self.b = question.optionB
        self.c = question.optionC
        self.d = question.optionD
        self.question = question.questionString
        self.answer = question.answer
    }
    
    func setLabels(){
        buttonA.setTitle(a, forState: UIControlState.Normal)
        buttonB.setTitle(b, forState: UIControlState.Normal)
        buttonC.setTitle(c, forState: UIControlState.Normal)
        buttonD.setTitle(d, forState: UIControlState.Normal)
        questionLabel.text = question
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
