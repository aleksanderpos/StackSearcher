//
//  StackRepository.swift
//  EHStackSearcher
//
//  Created by Aleksander Posobiec  on 06.08.2018.
//  Copyright © 2018 Aleksander Posobiec . All rights reserved.
//

import Foundation
typealias StackQuestionsRepositoryCompletionHandler = (([StackQuestion]?, Error?) -> Void)
typealias StackAnswerRepositoryCompletionHandler = ((StackAnswer?, Error?) -> Void)

protocol StackRepositoryProtocol: class {
    func getStackQuestion(query: String, completion: @escaping StackQuestionsRepositoryCompletionHandler)
    func getStackAnswer(answerId: String, completion: @escaping StackAnswerRepositoryCompletionHandler)
}

class StackRepository: StackRepositoryProtocol {

    private var stackNetworking: StackNetworking
    private var stackSerializer: StackSerializer

    init(networking: StackNetworking, serializer: StackSerializer) {
        self.stackNetworking = networking
        self.stackSerializer = serializer
    }

    func getStackQuestion(query: String, completion: @escaping StackQuestionsRepositoryCompletionHandler) {
        stackNetworking.fetchStackQuestion(query: query) { (json, error) in
            guard let json = json else {
                completion(nil, error)
                return
            }
            completion(self.stackSerializer.unserializeQuestions(json), error)
        }
    }

    func getStackAnswer(answerId: String, completion: @escaping StackAnswerRepositoryCompletionHandler) {
        stackNetworking.fetchStackAnswer(answerId: answerId) { (json, error) in
            guard let json = json else {
                completion(nil, error)
                return
            }
            completion(self.stackSerializer.unserializeAnswer(json), error)
        }
    }

}


