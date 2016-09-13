//
//  TestViewController.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 5/07/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    var test = Test()
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var xVal = 0
    var yVal = 0
    var textfields = [UITextField]()
    var labels = [UILabel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        test.loadQuestions()
        loadViews()
        addToScreen()
        //TODO: Update progress tracker
        for textfield in textfields {
            textfield.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadViews(){
        var count = test.chunks.keys.count
        var gapCount = 1
        for chunk in 1...count {
            if (test.chunks[chunk]! != "newline"){
                var dimensions: (CGFloat, CGFloat, CGFloat, CGFloat) = calcDimensions(test.chunks[chunk]!)
                //print(dimensions)
                label(dimensions.0, y: dimensions.1, width: dimensions.2, height: dimensions.3, text: test.chunks[chunk]!)
            //else insert text field
                if (chunk != count){
                    dimensions = calcDimensions(test.gaps[gapCount]!)
                    //print(dimensions)
                    textField(dimensions.0, y: dimensions.1, width: dimensions.2, height: dimensions.3, text: test.gaps[gapCount]!)
                    gapCount = gapCount + 1
                }
                
            }
        }
    }
    
    func textField(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text : String){
        //print("making text field")
        let textField = UITextField(frame: CGRectMake(x, y, screenSize.width, height))
        textField.textAlignment = NSTextAlignment.Center
        textField.textColor = UIColor.blueColor()
        let myColor : UIColor = UIColor( red: 0, green: (108/255), blue: (169/255), alpha: 0.5 )
        textField.backgroundColor = myColor
        textField.autocapitalizationType = UITextAutocapitalizationType.Words
        textField.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        textField.placeholder = "Enter answer"
        textfields.append(textField)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //print("ending editing")
        textField.resignFirstResponder()
        return true
    }
    
    func label(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text : String){
        //print("making label")
        let label = UILabel(frame: CGRectMake(x+5, y, width-10, height))
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        label.text = text
        label.textAlignment = NSTextAlignment.Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 0
        labels.append(label)
    }
    
    func calcDimensions(text: String) -> (x: CGFloat, y:CGFloat, width: CGFloat, height: CGFloat){
        //print("calculating dimensions")
        //create a UI view and resize to see the amount of space this text will take up
        let smallFrame = CGRect(x: 0, y: 0, width: Int(screenSize.width), height: Int(screenSize.height))
        
        let textView = UITextView(frame: smallFrame)
        textView.text = text
        textView.editable = false
        textView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        textView.sizeToFit()
        
        let height = textView.contentSize.height
        let width = textView.contentSize.width
        
        let finalY = yVal
        
        yVal = (yVal + Int(height))
        
        return (CGFloat(xVal) ,CGFloat(finalY),width,height)
    }
    
    func addToScreen(){
        for label in 0...labels.count-1{
            self.containerView.addSubview(labels[label])
            if (label != labels.count-1){
                self.containerView.addSubview(textfields[label])
                
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scrollView.contentSize.height = 1000
        self.scrollView.contentSize.width = screenSize.width
    }
    
    @IBAction func checkAnswers(sender: AnyObject) {
        if answerButton.currentTitle == "Check answers" {
            for textfield in textfields {
                let index = textfields.indexOf(textfield)!+1
                let enteredAnswer = String(textfield.text!).lowercaseString
                if enteredAnswer ==  "" {
                    print("No answer entered")
                    //tell the question tracker that the answer was false, so no progress is added
                    test.questionsAnswered[index] = false
                }
                else{
                    //evaluate answer
                    print("Entered answer= \(enteredAnswer)")
                    let correctAnswer = String(test.gaps[index]!).lowercaseString
                    print("Correct answer = \(correctAnswer)")
                    if enteredAnswer == correctAnswer {
                        textfield.backgroundColor = UIColor( red: (12/255), green: (245/255), blue: (29/255), alpha: 0.5 )
                        test.questionsAnswered[index] = true
                    }
                    else {
                        textfield.backgroundColor = UIColor( red: (182/255), green: (18/255), blue: (26/255), alpha: 0.5 )
                        test.questionsAnswered[index] = false
                    }
                }
                test.updateProgress()
            }
            answerButton.setTitle("Reset questions", forState: UIControlState.Normal)
        }
        else {
            for textfield in textfields {
                let index = textfields.indexOf(textfield)!+1
                if (test.questionsAnswered[index] == false) {
                    textfield.text = ""
                    textfield.placeholder = "Enter answer"
                    textfield.backgroundColor = UIColor(red: 0, green: (108/255), blue: (169/255), alpha: 0.5)
                }
            }
            answerButton.setTitle("Check answers", forState: UIControlState.Normal)
        }
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
