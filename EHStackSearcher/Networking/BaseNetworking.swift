//
//  BaseNetworking.swift
//  EHStackSearcher
//
//  Created by Aleksander Posobiec  on 06.08.2018.
//  Copyright © 2018 Aleksander Posobiec . All rights reserved.
//
import SwiftyJSON

typealias JsonDictionary = [String: Any]
typealias BaseNetworkingCompletionHandler = (JSON?, Error?) -> Void
typealias ErrorFromResponseCompletionHandler = (String?) -> Void

public enum HTTPMethod : String {
    case get = "GET"
}
struct Endpoints {
    static let baseURL = "https://api.stackexchange.com"
}

class BaseNetworking {
    
    private var task: URLSessionTask?
    
    func performRequest(with url: URL, completion: @escaping BaseNetworkingCompletionHandler) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        task?.cancel()
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 12.0)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        task = session.dataTask(with: urlRequest, completionHandler: { data,response,error in
            if let data = data {
                completion(JSON(data), nil)
            } else {
                completion(nil, nil)
            }
        })
        task?.resume()
    }
}




