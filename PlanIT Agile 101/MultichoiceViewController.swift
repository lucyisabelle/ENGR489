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
        buttonA.setTitle("hello", for: UIControlState())
        setLabels()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func initiate() -> MultichoiceViewController {
        return UIStoryboard(name : "Main", bundle: nil).instantiateViewController(withIdentifier: "MultichoiceViewController") as! MultichoiceViewController
    }
    
    func test() {
        print("Test function")
        //buttonA.setTitle("Test", forState: UIControlState.Normal)
    }
    
    func setValues(_ question: Question){
        self.a = question.optionA
        self.b = question.optionB
        self.c = question.optionC
        self.d = question.optionD
        self.question = question.questionString
        self.answer = question.answer
    }
    
    func setLabels(){
        buttonA.setTitle(a, for: UIControlState())
        buttonB.setTitle(b, for: UIControlState())
        buttonC.setTitle(c, for: UIControlState())
        buttonD.setTitle(d, for: UIControlState())
        questionLabel.text = question
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        print("Next button pressed")
        nextPage()
    }

    @IBAction func aPressed(_ sender: UIButton) {
        if buttonA.currentTitle == answer {
            buttonA.backgroundColor = UIColor( red: (12/255), green: (245/255), blue: (29/255), alpha: 0.75 )
        }
        else {
            buttonA.backgroundColor = UIColor( red: (182/255), green: (18/255), blue: (26/255), alpha: 0.75 )
        }
        nextPage()
    }
    
    @IBAction func bPressed(_ sender: UIButton) {
        if buttonB.currentTitle == answer {
            buttonB.backgroundColor = UIColor( red: (12/255), green: (245/255), blue: (29/255), alpha: 0.75 )
        }
        else {
            buttonB.backgroundColor = UIColor( red: (182/255), green: (18/255), blue: (26/255), alpha: 0.75 )
        }
        nextPage()
    }
    
    @IBAction func cPressed(_ sender: UIButton) {
        if buttonC.currentTitle == answer {
            buttonC.backgroundColor = UIColor( red: (12/255), green: (245/255), blue: (29/255), alpha: 0.75 )
        }
        else {
            buttonC.backgroundColor = UIColor( red: (182/255), green: (18/255), blue: (26/255), alpha: 0.75 )
        }
        nextPage()
    }
    
    @IBAction func dPressed(_ sender: UIButton) {
        if buttonD.currentTitle == answer {
            buttonD.backgroundColor = UIColor( red: (12/255), green: (245/255), blue: (29/255), alpha: 0.75 )
        }
        else {
            buttonD.backgroundColor = UIColor( red: (182/255), green: (18/255), blue: (26/255), alpha: 0.75 )
        }
        nextPage()
    }
    
    func nextPage(){
        print("next page")
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
