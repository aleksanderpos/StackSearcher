//
//  StackSearchViewModel.swift
//  EHStackSearcher
//
//  Created by Aleksander Posobiec  on 07.08.2018.
//  Copyright © 2018 Aleksander Posobiec . All rights reserved.
//

import Foundation

typealias StackQuestionsCompletionHandler = ([StackQuestion]?, Error?) -> Void
typealias StackAnswerCompletionHandler = (StackAnswer?, Error?) -> Void

protocol StackSearchViewModelProtocol {
    var questions: [StackQuestion] {get set}
    func getQuestions(by query: String, completion: @escaping StackQuestionsCompletionHandler)
    func getAnswer(for answerId: String, completion: @escaping StackAnswerCompletionHandler)
}
class StackSearchViewModel: StackSearchViewModelProtocol {
    
    var questions: [StackQuestion] = []
    private let stackRepository: StackRepository
    
    init(stackRepository: StackRepository) {
        self.stackRepository = stackRepository
    }
    
    func getQuestions(by query: String, completion: @escaping StackQuestionsCompletionHandler) {
        stackRepository.getStackQuestion(query: query) { (stackQuestions, error) in
            if let stackQuestions = stackQuestions {
                self.questions = stackQuestions
                completion(stackQuestions,error)
            }
        }
    }
    
    func getAnswer(for answerId: String, completion: @escaping StackAnswerCompletionHandler) {
        stackRepository.getStackAnswer(answerId: answerId) { (stackAnswer, error) in
            completion(stackAnswer, error)
        }
    }
    
}
