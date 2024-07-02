//
//  TodoListView.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit

import SnapKit


class TodoListView: BaseView {
    
    let tableView = UITableView()
    
    override func configHierarchy() {
        self.addSubview(tableView)
    }
    
    override func configLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configView() {
        configTableView()
    }
    
    func configTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorColor = .systemGray6
        tableView.separatorStyle = .singleLine
    }
}
