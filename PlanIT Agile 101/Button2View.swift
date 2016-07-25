//
//  Button2View.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 25/07/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class Button2View: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        // Drawing code
        var path = UIBezierPath(ovalInRect: rect)
        
        //for now the colour is green, but it will be white
        //find out if i can put an image in this rectangle
        UIColor.greenColor().setFill()
        path.fill()
    }
    

}
