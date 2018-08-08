//
//  StackSearchView.swift
//  EHStackSearcher
//
//  Created by Aleksander Posobiec  on 06.08.2018.
//  Copyright © 2018 Aleksander Posobiec . All rights reserved.
//

import UIKit
import SnapKit

class StackSearchView: UIView {
    
    let resultTableView = UITableView()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    func setupView() {
        addSubview(resultTableView)
        addSubview(activityIndicator)
        
        resultTableView.separatorColor = UIColor.orange
        resultTableView.tableFooterView = UIView(frame: .zero)
        resultTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = UIColor.orange
        activityIndicator.layer.masksToBounds = false
        activityIndicator.layer.cornerRadius = 6.0
    }
    
}
