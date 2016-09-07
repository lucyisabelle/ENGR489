//
//  ProgressView.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 7/09/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    var percentageComplete = 60.0
    
    override func drawRect(rect: CGRect) {
        UIColor( red: 0, green: (108/255), blue: (169/255), alpha: CGFloat(percentageComplete/100) ).setFill()
        //UIColor.blueColor().setFill()
        let canvas = UIGraphicsGetCurrentContext()
        let width = (Double(bounds.width)/100) * percentageComplete
        print("width = \(width)")
        let rect = CGRect(x: 0, y: 0, width: CGFloat(width), height: bounds.height)
        
        CGContextAddRect(canvas, rect)
        CGContextFillPath(canvas)
        
        
    }
    
}
