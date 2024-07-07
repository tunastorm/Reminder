//
//  TodoListView.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit

import SnapKit
import Then


final class TodoListView: BaseView {
    
    let tableView = UITableView().then {
        $0.separatorInset = .init(top: 0, left: 60.0, bottom: 0, right: 0)
        $0.separatorColor = .darkGray
    }
    
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
        tableView.backgroundColor = .black
        tableView.separatorColor = .systemGray6
        tableView.separatorStyle = .singleLine
    }
    
   
}
