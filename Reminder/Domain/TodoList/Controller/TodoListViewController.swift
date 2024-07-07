//
//  TodoListViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//
import UIKit

import RealmSwift


final class TodoListViewController: BaseViewController<TodoListView> {

    var delegate: UpdateListDelegate?
   
    var repository = TodoRepository()
    var object = TodoModel.self
 
    
    var filter: TodoFilter?
    var date: Date?
    
    var list: [TodoModel] = [] {
        didSet {
            rootView.tableView.reloadData()
        }
    }
    
    var menuItems: [UIAction]?

    override func viewDidLoad() {
        super.viewDidLoad()
        configInteraction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        list = configList(sort: TodoModel.Column.deadline)
        guard let filter else {
            return
        }
        rootView.configHeaderView(filter: filter, date: date)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.configCountList()
    }
    
    override func configNavigationbar(bgColor: UIColor) {
        super.configNavigationbar(bgColor: bgColor)
        configFilterBarButton()
    }
    
    override func configInteraction() {
        configSearchContoller()
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.register(TodoListTableViewCell.self,
                                    forCellReuseIdentifier: TodoListTableViewCell.identifier)
    }
    
    func configSearchContoller() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        rootView.searchBar = searchController.searchBar
        rootView.searchBar?.setShowsCancelButton(false, animated: false)
        rootView.searchBar?.delegate = self
        rootView.configSearchBar()
    }
    
    func configList(sort: TodoModel.Column, acending: Bool = true) -> [TodoModel] {
        return repository.fetchAllFiltered(obejct: object, sortKey: sort, acending: acending) {
            switch filter {
            case .today: $0.deadline != nil && $0.deadline == today
            case .planned: $0.deadline != nil && $0.deadline > today
            case .flagged: $0.isFlag
            case .completed: $0.isComplete
            case .lowPriority: $0.priority == TodoModel.Column.PriortyLevel.low.rawValue
            case .date: $0.deadline != nil && $0.deadline == self.date
            default: $0.isComplete || !$0.isComplete // all case
            }
        }
        print(#function, filter, list)
    }
    
    func configFilterBarButton() {
        let deadlineFilter = UIAction(title: "마감일순 정렬", image: UIImage(systemName: "calendar")) { _ in
            self.configList(sort: TodoModel.Column.deadline)
        }
        
        let titleFilter = UIAction(title: "제목순 정렬", image: UIImage(systemName: "textformat")) { _ in
            self.configList(sort: TodoModel.Column.title)
        }
        
        let priorityFilter = UIAction(title: "우선순위 낮음만", image: UIImage(systemName: "checkmark.square")) { _ in
            self.configList(sort: TodoModel.Column.priority)
        }
        
        menuItems = [deadlineFilter,titleFilter, priorityFilter]
        
        guard let menuItems else {
            return
        }
        var barButtonMenu: UIMenu = UIMenu(title: "", children: menuItems)
        let barButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "slider.horizontal.3"), menu: barButtonMenu)
        navigationItem.rightBarButtonItem = barButton
    }
    
    func fatchRealm() {
        rootView.tableView.reloadData()
    }
    
    @objc func updateIsComplete(_ sender: UIButton) {
        do {
            try realm.write {
                self.list[sender.tag].isComplete.toggle()
            }
            print(#function, sender.tag, list[sender.tag].isComplete)
            self.rootView.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        } catch {
            
        }
    }
}


