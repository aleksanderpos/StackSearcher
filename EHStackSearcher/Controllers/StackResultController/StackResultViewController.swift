//
//  StackResultViewController.swift
//  EHStackSearcher
//
//  Created by Aleksander Posobiec  on 07.08.2018.
//  Copyright © 2018 Aleksander Posobiec . All rights reserved.
//

import UIKit

class StackResultViewController: UIViewController {

    private let mainView: StackResultView
    private let viewModel: StackResultViewModel

    init(view: StackResultView, viewModel: StackResultViewModel) {
        self.mainView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        mainView.setupView(with: viewModel.question)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
