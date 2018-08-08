//
//  StackResultView.swift
//  EHStackSearcher
//
//  Created by Aleksander Posobiec  on 07.08.2018.
//  Copyright © 2018 Aleksander Posobiec . All rights reserved.
//

import UIKit
private struct Constants {
    static let spacing = 64.0
    static let borderWidth: CGFloat = 2.0
}
class StackResultView: UIView {

    let questionTitleLabel = UILabel()
    let questionTextView = UITextView()
    let answerTextView = UITextView()

    func setupView(with question: StackQuestion) {
        backgroundColor = UIColor.white
        addSubview(questionTitleLabel)
        addSubview(questionTextView)
        addSubview(answerTextView)

        questionTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(Constants.spacing)
            make.leading.trailing.equalToSuperview()
        }
        questionTitleLabel.numberOfLines = 0
        questionTitleLabel.textColor = UIColor.orange
        questionTitleLabel.text = question.title?.htmlToString

        questionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(questionTitleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(snp.centerY)
        }

        questionTextView.layer.borderColor = UIColor.orange.cgColor
        questionTextView.layer.borderWidth = Constants.borderWidth
        questionTextView.attributedText = question.body?.htmlToAttributedString
        questionTextView.isEditable = false

        if let isAnswered = question.isAnswered, isAnswered {
            answerTextView.snp.makeConstraints { (make) in
                make.top.equalTo(snp.centerY)
                make.leading.trailing.bottom.equalToSuperview()
            }

            answerTextView.attributedText = question.answer?.body?.htmlToAttributedString
            answerTextView.layer.borderColor = UIColor.green.cgColor
            answerTextView.layer.borderWidth = Constants.borderWidth
            answerTextView.isEditable = false
        }

    }
}
