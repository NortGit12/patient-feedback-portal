//
//  Survey.swift
//  patient-feedback-portal
//
//  Created by Jeff Norton on 11/8/21.
//

import Foundation

struct Survey {
    var bundle: Bundle
    var dateAvailable: Date?
    var dateCompleted: Date?
    var lastUpdatedDate: Date
    
}

struct QuestionAnswers {
    var question: String
    var questionType: QuestionType
    var validAnswers: [ValidAnswerType]
    var submittedAnswer: String
}

enum QuestionType: String {
    case range = "Range"
    case yesNo = "Yes/No"
    case multipleSelection = "Multiple Selection"
}

enum ValidAnswerType: String {
    // Order: Groups then cases ascending
    
    // _General
    case other
    
    // range
    case oneToFive = "1 to 5"
    case oneToTen = "1 to 10"
    
    // yesNo
    case no = "No"
    case yes = "Yes"
}
