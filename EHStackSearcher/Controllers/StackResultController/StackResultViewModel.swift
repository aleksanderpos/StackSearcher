//
//  StackResultViewModel.swift
//  EHStackSearcher
//
//  Created by Aleksander Posobiec  on 08.08.2018.
//  Copyright © 2018 Aleksander Posobiec . All rights reserved.
//

protocol StackResultViewModelProtocol {
    var question: StackQuestion { get set }
}
class StackResultViewModel: StackResultViewModelProtocol {
    var question: StackQuestion = StackQuestion()

    init(question: StackQuestion) {
        self.question = question
    }
}
