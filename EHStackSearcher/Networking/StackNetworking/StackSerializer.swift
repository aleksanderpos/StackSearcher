//
//  StackSerializer.swift
//  EHStackSearcher
//
//  Created by Aleksander Posobiec  on 07.08.2018.
//  Copyright © 2018 Aleksander Posobiec . All rights reserved.
//
import SwiftyJSON

struct StackSerializerParameters {

    static let items = "items"

    struct StackQuestionParameters {
        static let title = "title"
        static let body = "body"
        static let isAnswered = "is_answered"
        static let answerId = "accepted_answer_id"
    }
    
    struct StackAnswerParameters {
        static let body = "body"
    }
}

protocol StackSerializerProtocol: class {
    func unserializeQuestions(_ json: JSON) -> [StackQuestion]
    func unserializeAnswer(_ json: JSON) -> StackAnswer
}

class StackSerializer: StackSerializerProtocol {

    func unserializeQuestions(_ json: JSON) -> [StackQuestion] {
        var questions = [StackQuestion]()
        let jsonItems = json[StackSerializerParameters.items]
        for (_, jsonItem) in jsonItems {
            var question = StackQuestion()
            question.title = jsonItem[StackSerializerParameters.StackQuestionParameters.title].string
            question.body = jsonItem[StackSerializerParameters.StackQuestionParameters.body].string
            question.isAnswered = jsonItem[StackSerializerParameters.StackQuestionParameters.isAnswered].bool
            if let hasAnswer = question.isAnswered, hasAnswer {
                question.answerId = jsonItem[StackSerializerParameters.StackQuestionParameters.answerId].numberValue.stringValue
            }
            questions.append(question)
        }
        return questions
    }

    func unserializeAnswer(_ json: JSON) -> StackAnswer {
        var answer = StackAnswer()
        let jsonItems = json[StackSerializerParameters.items]
        for (_, jsonItem) in jsonItems {
            answer.body = jsonItem[StackSerializerParameters.StackAnswerParameters.body].string
        }
        return answer
    }
}
