//
//  StackModels.swift
//  EHStackSearcher
//
//  Created by Aleksander Posobiec  on 07.08.2018.
//  Copyright © 2018 Aleksander Posobiec . All rights reserved.
//

import Foundation

struct StackQuestion {
    var title: String?
    var body: String?
    var isAnswered: Bool?
    var answerId: String?
    var answer: StackAnswer?
}

struct StackAnswer {
    var body: String?
}
