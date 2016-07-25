//
//  ButtonView.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 25/07/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class ButtonView: UIButton {
    
    let percentageComplete = 20

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        var path = UIBezierPath(ovalInRect: rect)
        UIColor.greenColor().setFill()
        path.fill()
    }
    
}
