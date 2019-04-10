//
//  Question.swift
//  Quizzler
//
//  Created by Reza Dehnavi on 4/6/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

public class Question {
    
    let question:String
    let answer:Bool
    
    init(text:String, correctAnswer:Bool) {
        self.question = text
        self.answer = correctAnswer
    }
    
}
