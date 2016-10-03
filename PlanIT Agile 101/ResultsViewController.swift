//
//  ResultsViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 3/10/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
