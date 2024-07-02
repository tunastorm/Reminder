//
//  TodoListViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//
import UIKit

import RealmSwift


class TodoListViewController: BaseViewController<TodoListView> {
    
    var list: Results<TodoModel>? {
        didSet {
            rootView.tableView.reloadData()
        }
    }
    
    var menuItems: [UIAction]?

    override func viewDidLoad() {
        super.viewDidLoad()
        configInteraction()
        configList()
        print(#function, realm.configuration.fileURL)
    }
    
    override func configNavigationbar(bgColor: UIColor) {
        super.configNavigationbar(bgColor: bgColor)
        configFilterBarButton()
    }
    
    override func configInteraction() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.register(TodoListTableViewCell.self,
                                    forCellReuseIdentifier: TodoListTableViewCell.identifier)
    }
    
    func configFilterBarButton() {
        let deadlineFilter = UIAction(title: "마감일순 정렬", image: UIImage(systemName: "calendar")) {_ in
            self.list = self.realm.objects(TodoModel.self).sorted(byKeyPath: TodoModel.Column.deadline.rawValue, ascending: true)
        }
        
        let titleFilter = UIAction(title: "제목순 정렬", image: UIImage(systemName: "textformat")) { _ in
            self.list = self.realm.objects(TodoModel.self).sorted(byKeyPath: TodoModel.Column.title.rawValue, ascending: true)
        }
        
        let priorityFilter = UIAction(title: "우선순위 낮음만", image: UIImage(systemName: "checkmark.square")) { _ in
            self.list = self.realm.objects(TodoModel.self)
                             .where { $0.priority > 0 && $0.priority <= 3 }
                             .sorted(byKeyPath: TodoModel.Column.priority.rawValue, ascending: true)
        }
        
        menuItems = [deadlineFilter,titleFilter, priorityFilter]
        
        guard let menuItems else {
            return
        }
        var barButtonMenu: UIMenu = UIMenu(title: "", children: menuItems)
        let barButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "slider.horizontal.3"), menu: barButtonMenu)
        navigationItem.rightBarButtonItem = barButton
    }
    
    
    func configList() {
        list = realm.objects(TodoModel.self)
    }
    
    func fatchRealm() {
        rootView.tableView.reloadData()
    }
}


