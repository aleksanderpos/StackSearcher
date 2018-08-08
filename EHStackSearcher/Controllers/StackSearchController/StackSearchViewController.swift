//
//  StackSearchViewController.swift
//  EHStackSearcher
//
//  Created by Aleksander Posobiec  on 06.08.2018.
//  Copyright © 2018 Aleksander Posobiec . All rights reserved.
//

import UIKit
private struct Constants {
    static let cellIdentifier = "QuestionCellIdentifier"
    static let searchText = "Search..."
    static let navTitle = "Stackoverflow Searcher"
}
class StackSearchViewController: UIViewController {
    
    private let mainView: StackSearchView
    private let viewModel: StackSearchViewModel
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(view: StackSearchView, viewModel: StackSearchViewModel) {
        self.mainView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        mainView.setupView()
        mainView.resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        mainView.resultTableView.delegate = self
        mainView.resultTableView.dataSource = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.searchText
        
        navigationItem.title = Constants.navTitle
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func openAnswer(for question: StackQuestion) {
        DispatchQueue.main.async {
            self.mainView.activityIndicator.stopAnimating()
            self.navigationController?.pushViewController(StackResultViewController(view: StackResultView(), viewModel: StackResultViewModel(question: question)), animated: true)
        }
    }
}
extension StackSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath as IndexPath)
        guard let titleText = viewModel.questions[indexPath.row].title else {
            return cell
        }
        
        cell.textLabel?.text = titleText
        cell.textLabel?.textColor = UIColor.lightGray
        cell.textLabel?.numberOfLines = 0
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
        
        if let _ = viewModel.questions[indexPath.row].answerId {
            cell.textLabel?.textColor = UIColor.black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQuestion = viewModel.questions[indexPath.row]
        if let isAnswered = selectedQuestion.isAnswered, isAnswered {
            if let _ = selectedQuestion.answer {
                self.openAnswer(for: selectedQuestion)
            } else if let answerId = selectedQuestion.answerId {
                mainView.activityIndicator.startAnimating()
                viewModel.getAnswer(for: answerId) { (stackAnswer, error) in
                    self.viewModel.questions[indexPath.row].answer = stackAnswer
                    self.openAnswer(for: self.viewModel.questions[indexPath.row])
                }
            }
        } else {
            openAnswer(for: selectedQuestion)
        }
    }
}

extension StackSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchQuery = searchBar.text {
            if !searchQuery.isEmpty {
                mainView.activityIndicator.startAnimating()
                viewModel.getQuestions(by: searchQuery) { questions, error in
                    DispatchQueue.main.async {
                        self.mainView.activityIndicator.stopAnimating()
                        if questions != nil {
                            self.mainView.resultTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
}
