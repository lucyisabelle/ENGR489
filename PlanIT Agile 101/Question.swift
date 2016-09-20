//
//  Question.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 19/09/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class Question {
    
    var multichoice : Bool
    var optionA : String
    var optionB : String
    var optionC : String
    var optionD : String
    var answer: String
    
    init(multichoice: Bool, a : String, b : String, c : String, d : String, answer : String) {
        self.multichoice = multichoice
        self.optionA = a
        self.optionB = b
        self.optionC = c
        self.optionD = d
        self.answer = answer
    }
}
