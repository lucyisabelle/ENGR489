//
//  ButtonView.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 25/07/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class ButtonView: UIButton {
    
    var percentageComplete = Int()
    let π:CGFloat = CGFloat(M_PI)
    var moduleImage = UIImage(named: "module_1")
    
    @IBInspectable var counter: Int = 5
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.blue

    override func draw(_ rect: CGRect) {
        //print("My progress is: \(percentageComplete) %")
        // Drawing code
        self.setBackgroundImage(moduleImage, for: UIControlState())
        let path1 = UIBezierPath(ovalIn: rect)
        UIColor.white.setFill()
        path1.fill()

        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = 2
        let startAngle: CGFloat = 3 * π / 2
        var endAngle: CGFloat = π
        //convert the percentage complete to degrees.
        if percentageComplete != 0 {
            var degrees = (Double(percentageComplete) / 100) * 360
            degrees = (360/100) * Double(percentageComplete)
            //convert the degrees value to radians
            let endAngleDouble = Double(startAngle) + ((degrees * M_PI) / 180)
            endAngle = CGFloat(endAngleDouble)
            print("Percentage complete = \(percentageComplete)")
            print("Degrees = \(degrees)")
            print("endAngle = \(endAngle)")
        }
        else {
            endAngle = startAngle
        }
        
        // 5
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        // 6
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        

        
        //trying to add in image
        //remember this needs to change dynamically
        
        //first need to resize the image
        //var resizedImage = self.ResizeImage(moduleImage!, targetSize: CGSizeMake(20.0, 20.0))
        
        //self.ResizeImage(moduleImage!, targetSize: CGSizeMake(10,10));
        
    }
    

    
    
}
