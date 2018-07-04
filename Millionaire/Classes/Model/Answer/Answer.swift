//
//  Answer.swift
//  AiLaTrieuPhu
//
//  Created by hieunguyen on 7/6/14.
//  Copyright (c) 2014 FRUITYSOLUTION. All rights reserved.
//

import Foundation
class Answer :NSObject{
    var questionId: NSString = ""
    var answerA: NSString = ""
    var answerB: NSString = ""
    var answerC: NSString = ""
    var answerD: NSString = ""
    var isTrue: NSString = ""
    func intiliazer(_ questionId: NSString, ansA: NSString, ansB: NSString, ansC: NSString, ansD: NSString, isTrue: NSString){
        self.questionId = questionId
        self.answerA = ansA
        self.answerB = ansB
        self.answerC = ansC
        self.answerD = ansD
        self.isTrue = isTrue
    }
}
