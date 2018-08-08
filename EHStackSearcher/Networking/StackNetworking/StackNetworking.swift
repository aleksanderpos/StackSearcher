//
//  StackNetworking.swift
//  EHStackSearcher
//
//  Created by Aleksander Posobiec  on 07.08.2018.
//  Copyright © 2018 Aleksander Posobiec . All rights reserved.
//

import Foundation

protocol StackNetworkingProtocol: class {
    func fetchStackQuestion(query:String, completion: @escaping BaseNetworkingCompletionHandler)
    func fetchStackAnswer(answerId: String, completion: @escaping BaseNetworkingCompletionHandler)
}

class StackNetworking: BaseNetworking, StackNetworkingProtocol {

    let baseURL = "https://api.stackexchange.com"
    let questionQueryURL = "/2.2/search/advanced?order=desc&sort=activity&title={query}&site=stackoverflow&filter=!9Z(-wwYGT"
    let answerQueryURL = "/2.2/answers/{id}?order=desc&sort=activity&site=stackoverflow&filter=!9Z(-wzu0T"

    func fetchStackQuestion(query: String, completion: @escaping BaseNetworkingCompletionHandler) {
        let finalQuery = query.replacingOccurrences(of: " ", with: "%20")
        guard let properURL = URL(string: baseURL + questionQueryURL.replacingOccurrences(of: "{query}", with: finalQuery)) else {
            return
        }
        performRequest(with: properURL) { (json, error) in
            completion(json, error)
        }
    }

    func fetchStackAnswer(answerId: String, completion: @escaping BaseNetworkingCompletionHandler) {
        guard let properURL = URL(string: baseURL + answerQueryURL.replacingOccurrences(of: "{id}", with: answerId)) else {
            return
        }

        performRequest(with: properURL) { (json, error) in
            completion(json,error)
        }
    }


}
