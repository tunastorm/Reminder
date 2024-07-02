//
//  TodoListViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//
import UIKit

import RealmSwift


class TodoListViewController: BaseViewController<TodoListView> {
    
    let realm = try! Realm()
    
    var list: Results<TodoModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configInteraction()
        configList()
        print(#function, realm.configuration.fileURL)
    }
    
    override func configInteraction() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
//        rootView.tableView.prefetchDataSource = self
        rootView.tableView.register(TodoListTableViewCell.self,
                                    forCellReuseIdentifier: TodoListTableViewCell.identifier)
    }
    
    func configList() {
        list = realm.objects(TodoModel.self)
    }
}


