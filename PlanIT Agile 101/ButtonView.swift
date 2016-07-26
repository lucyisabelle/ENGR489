//
//  ButtonView.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 25/07/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class ButtonView: UIButton {
    
    let noOfModules = 10
    let π:CGFloat = CGFloat(M_PI)
    var image = UIImage(named: "module_1")
    
    @IBInspectable var counter: Int = 5
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    //TODO: change this to the correct PlanIT colours
    @IBInspectable var counterColor: UIColor = UIColor.blueColor()
    //note this will be the button that tracks progress, it needs to be an arc
    
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        var path1 = UIBezierPath(ovalInRect: rect)
        UIColor.whiteColor().setFill()
        path1.fill()
        // 1
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        // 2
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        // 3
        let arcWidth: CGFloat = 5
        
        // 4
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        
        // 5
        var path = UIBezierPath(arcCenter: center,
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
        self.setBackgroundImage(image, forState: UIControlState.Normal)

        
    }
    
}
