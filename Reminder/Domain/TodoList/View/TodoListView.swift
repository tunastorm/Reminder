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
    
    var searchBar: UISearchBar?
    
    let headerView = HeaderView()
    
    let tableView = UITableView().then {
        $0.separatorInset = .init(top: 0, left: 60.0, bottom: 0, right: 0)
        $0.separatorColor = .darkGray
    }
    
    override func configHierarchy() {
        if let searchBar {
            self.addSubview(searchBar)
        }
        self.addSubview(headerView)
        self.addSubview(tableView)
    }
    
    override func configLayout() {
        headerView.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.top.equalToSuperview().inset(150)
            $0.horizontalEdges.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
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
    
    func configSearchBar() {
        searchBar?.tintColor = .systemBlue
        searchBar?.searchTextField.textColor = .white
        print(#function, "서치바 색상", searchBar?.searchTextField.textColor)
    }
   
    func configHeaderView(filter: TodoFilter, date: Date?) {
        var title: String?
        if let date {
            title = Utils.dateFormatter.string(from: date)
        } else {
            title = filter.krName
        }
        guard let title else {
            return
        }
        headerView.configHeaderLabel(title: title)
    }
}
