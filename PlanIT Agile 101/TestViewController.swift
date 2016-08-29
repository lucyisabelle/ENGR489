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
                print(dimensions)
                label(dimensions.0, y: dimensions.1, width: dimensions.2, height: dimensions.3, text: test.chunks[chunk]!)
            //else insert text field
                if (chunk != count){
                    dimensions = calcDimensions(test.gaps[gapCount]!)
                    print(dimensions)
                    textField(dimensions.0, y: dimensions.1, width: dimensions.2, height: dimensions.3, text: test.gaps[gapCount]!)
                    gapCount = gapCount + 1
                }
                
            }
        }
    }
    
    func textField(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text : String){
        print("making text field")
        let textField = UITextField(frame: CGRectMake(x, y, width, height))
        textField.textAlignment = NSTextAlignment.Center
        textField.textColor = UIColor.blueColor()
        textField.borderStyle = UITextBorderStyle.Line
        textField.autocapitalizationType = UITextAutocapitalizationType.Words
        textField.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        textField.text = text
        
        textfields.append(textField)
    }
    
    func label(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text : String){
        print("making label")
        let label = UILabel(frame: CGRectMake(x, y, width, height))
        //label.center = CGPointMake(160, 284)
        //label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        label.text = text
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 0
        //self.view.addSubview(label)
        labels.append(label)
    }
    
    func calcDimensions(text: String) -> (x: CGFloat, y:CGFloat, width: CGFloat, height: CGFloat){
        print("calculating dimensions")
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
            self.view.addSubview(labels[label])
            if (label != labels.count-1){
                print(textfields.count)
                print(label)
                self.view.addSubview(textfields[label])
            }
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
