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
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    //TODO: change this to the correct PlanIT colours
    @IBInspectable var counterColor: UIColor = UIColor.blueColor()
    //note this will be the button that tracks progress, it needs to be an arc
    
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        print("My progress is: \(percentageComplete) %")
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
        let startAngle: CGFloat = 3 * π / 2 //original value: 3 * π / 4
        var endAngle: CGFloat = π //original value: π / 4
        //convert the percentage complete to degrees.
        if percentageComplete != 0 {
            var degrees = (Double(percentageComplete) / 100) * 360
            //convert the degrees value to radians
            endAngle = CGFloat((degrees * M_PI) / 180)
        }
        else {
            endAngle = startAngle
        }
        
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
        
        //first need to resize the image
        //var resizedImage = self.ResizeImage(moduleImage!, targetSize: CGSizeMake(20.0, 20.0))
        self.setBackgroundImage(moduleImage, forState: UIControlState.Normal)

        
    }
    
    
    //code from stack overflow http://stackoverflow.com/questions/31314412/how-to-resize-image-in-swift?rq=1
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
}
