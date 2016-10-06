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
    let screenSize: CGRect = UIScreen.main.bounds
    var xVal = 0
    var yVal = 0
    var textfields = [UITextField]()
    var labels = [UILabel]()
    var screenLength = 200

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        test.loadQuestions()
        loadViews()
        addToScreen()
        //TODO: Update progress tracker
        for textfield in textfields {
            textfield.delegate = self
            //textfield.inputView = self.scrollView
            textfield.becomeFirstResponder()
        }
        
        scrollView.delaysContentTouches = false
        NotificationCenter.default.addObserver(self, selector: #selector(TestViewController.keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TestViewController.keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)

    }
    
    func updateTextViewSizeForKeyboardHeight(keyboardHeight: CGFloat) {
        let x = scrollView.contentOffset.x
        let y = scrollView.contentOffset.y
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - keyboardHeight)
    }
    
    func keyboardDidShow(_ notification: NSNotification) {
        if let rectValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
            let keyboardSize = rectValue.cgRectValue.size
            print(keyboardSize)
            updateTextViewSizeForKeyboardHeight(keyboardHeight: keyboardSize.height)
        }
        /*if let rectValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
        let keyboardSize = rectValue.cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        var viewRect = view.frame
        viewRect.size.height -= keyboardSize.height
        if CGRectContainsPoint(viewRect, textField.frame.origin) {
            let scrollPoint = CGPointMake(0, textField.frame.origin.y - keyboardSize.height)
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
        }*/
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        updateTextViewSizeForKeyboardHeight(keyboardHeight: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } 
    
    func loadViews(){
        let count = test.chunks.keys.count
        var gapCount = 1
        for chunk in 1...count {
            if (test.chunks[chunk]! != "newline"){
                var dimensions: (CGFloat, CGFloat, CGFloat, CGFloat) = calcDimensions(test.chunks[chunk]!)
                label(dimensions.0, y: dimensions.1, width: dimensions.2, height: dimensions.3, text: test.chunks[chunk]!)
            //else insert text field
                if (chunk != count){
                    dimensions = calcDimensions(test.gaps[gapCount]!)
                    textField(x: dimensions.0, y: dimensions.1, width: dimensions.2, height: dimensions.3, text: test.gaps[gapCount]!)
                    gapCount = gapCount + 1
                }
                
            }
        }
    }
    
    func textField(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text : String){
        let textField = UITextField(frame: CGRect(x: x, y: y+10, width: screenSize.width+5, height: height))
        textField.textAlignment = NSTextAlignment.center
        textField.textColor = UIColor.blue
        let myColor : UIColor = UIColor( red: 0, green: (108/255), blue: (169/255), alpha: 0.5 )
        textField.backgroundColor = myColor
        textField.autocapitalizationType = UITextAutocapitalizationType.words
        textField.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        textField.placeholder = "Enter answer"
        textfields.append(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func label(_ x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text : String){
        let label = UILabel(frame: CGRect(x: x+10, y: y+10, width: width, height: height))
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        label.text = text
        label.textAlignment = NSTextAlignment.left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        labels.append(label)
    }
    
    func calcDimensions(_ text: String) -> (x: CGFloat, y:CGFloat, width: CGFloat, height: CGFloat){
        //create a UI view and resize to see the amount of space this text will take up
        let smallFrame = CGRect(x: 0, y: 0, width: Int(screenSize.width), height: Int(screenSize.height))
        
        let textView = UITextView(frame: smallFrame)
        textView.text = text
        textView.isEditable = true
        textView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        textView.sizeToFit()
        
        let height = textView.contentSize.height
        let width = textView.contentSize.width
        
        let finalY = yVal
        
        yVal = (yVal + Int(height))
        
        return (CGFloat(xVal) ,CGFloat(finalY),width,height)
    }
    
    func addToScreen(){
        self.screenLength = yVal
        self.viewWillLayoutSubviews()
        for label in 0...labels.count-1{
            self.containerView.addSubview(labels[label])
            if (label != labels.count-1){
                self.containerView.addSubview(textfields[label])
                
            }
        }
    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scrollView.contentSize.height = CGFloat(screenLength)
        self.scrollView.contentSize.width = screenSize.width
    }
    
    @IBAction func checkAnswers(_ sender: AnyObject) {
        if answerButton.currentTitle == "Check answers" {
            for textfield in textfields {
                let index = textfields.index(of: textfield)!+1
                let enteredAnswer = String(textfield.text!).lowercased()
                if enteredAnswer ==  "" {
                    print("No answer entered")
                    //tell the question tracker that the answer was false, so no progress is added
                    test.questionsAnswered[index] = false
                }
                else{
                    //evaluate answer
                    print("Entered answer= \(enteredAnswer)")
                    let correctAnswer = String(test.gaps[index]!).lowercased()
                    print("Correct answer = \(correctAnswer)")
                    if enteredAnswer == correctAnswer {
                        textfield.backgroundColor = UIColor( red: (12/255), green: (245/255), blue: (29/255), alpha: 0.5 )
                        test.questionsAnswered[index] = true
                    }
                    else {
                        textfield.text = "Correct answer = \(correctAnswer)"
                        textfield.backgroundColor = UIColor( red: (182/255), green: (18/255), blue: (26/255), alpha: 0.5 )
                        test.questionsAnswered[index] = false
                    }
                }
                test.updateProgress()
            }
            answerButton.setTitle("Reset questions", for: UIControlState())
        }
        else {
            for textfield in textfields {
                let index = textfields.index(of: textfield)!+1
                if (test.questionsAnswered[index] == false) {
                    textfield.text = ""
                    textfield.placeholder = "Enter answer"
                    textfield.backgroundColor = UIColor(red: 0, green: (108/255), blue: (169/255), alpha: 0.5)
                }
            }
            answerButton.setTitle("Check answers", for: UIControlState())
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
