//
//  SelectViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 12/09/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    
    var a = String()
    var b = String()
    var question = String()
    var answer = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setValues(_ question: Question){
        self.a = question.optionA
        self.b = question.optionB
        self.question = question.questionString
        self.answer = question.answer
    }
    
    func setLabels(){
        buttonA.setTitle(a, for: UIControlState())
        buttonB.setTitle(b, for: UIControlState())
        questionLabel.text = question
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

    @IBAction func nextButton(_ sender: UIButton) {
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
