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

    let questionLabel = UITextView()
    let answerLabel = UITextView()

    func setupView(with question: StackQuestion) {
        backgroundColor = UIColor.white
        addSubview(questionLabel)
        addSubview(answerLabel)

        questionLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Constants.spacing)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(snp.centerY)
        }
        answerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.centerY)
            make.leading.trailing.bottom.equalToSuperview()
        }

        questionLabel.layer.borderColor = UIColor.orange.cgColor
        questionLabel.layer.borderWidth = Constants.borderWidth
        questionLabel.attributedText = question.body?.htmlToAttributedString

        answerLabel.attributedText = question.answer?.body?.htmlToAttributedString
        answerLabel.layer.borderColor = UIColor.green.cgColor
        answerLabel.layer.borderWidth = Constants.borderWidth

    }
}
