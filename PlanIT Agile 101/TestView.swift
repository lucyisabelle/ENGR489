//
//  TestView.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 28/08/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class TestView :UIView {
    
    var test : Test
    
    override init(frame: CGRect) {
    }
    
    func setUp (test: Test){
        self.test = test
    }
    
}