//
//  TodoListViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//
import UIKit


class TodoListViewController: BaseViewController<TodoListView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configInteraction()
        print(#function, rootView.tableView.delegate)
    }
    
    override func configInteraction() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
//        rootView.tableView.prefetchDataSource = self
        rootView.tableView.register(TodoListTableViewCell.self,
                                    forCellReuseIdentifier: TodoListTableViewCell.identifier)
    }
}


