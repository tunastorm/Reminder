//
//  MainViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import RealmSwift


protocol MainViewDelegate {
    func goAddTodoViewController()
    func goTodoListViewController()
}

protocol UpdateListDelegate {
    func configCountList()
}


final class MainViewController: BaseViewController<MainView>, UpdateListDelegate {
    
 
    private let repository = TodoRepository()
    private let object = TodoModel.self
    
    var countList: [Int] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            guard let fileURL = realm.configuration.fileURL else {
                print(#function, "realm fileURL 찾을 수 없음")
                return
            }
            let version = try schemaVersionAtURL(fileURL)
            print(#function, "realmVersion: ", version)
            print(#function, fileURL)
        } catch {
            makeBasicToast(message: "realm 설정 오류", duration: 3.0, position: .bottom)
        }
    }
    
    override func configNavigationbar(bgColor: UIColor) {
        super.configNavigationbar(bgColor: bgColor)
        let leftBarButton = UIBarButtonItem(image: Resource.SystemImage.calendarBadgeCheckmark, style: .plain, target: self, action: #selector(calendarFilterClicked))
        let rightBarButton = UIBarButtonItem(image: Resource.SystemImage.ellipsisCircle, style: .plain, target: self, action: #selector(settingButtonClicked))
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func configDataBase() {
        configToday()
        configCountList()
    }
    
    override func configInteraction() {
        rootView.delegate = self
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        rootView.collectionView.register(MainCollectionViewCell.self,
                                         forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
    func getFilteredCount(_ filter: TodoFilter, sort: TodoModel.Column) -> Int {
        let result = repository.fetchAllFiltered(obejct: object, sortKey: sort) { todo in
            switch filter {
            case .today: todo.deadline != nil && todo.deadline == today
            case .planned: todo.deadline != nil && todo.deadline > today
            case .flagged: todo.isFlag
            case .completed: todo.isComplete
            default: todo.isComplete || !todo.isComplete
            }
        }
        print(#function, filter, result)
        return result == [] ? 0 : result.count
    }
    
    func configCountList() {
        TodoFilter.allCases.forEach { filter in
            if filter.rawValue < TodoFilter.displayCount {
                let count = getFilteredCount(filter, sort: TodoModel.Column.deadline)
                if countList.count == TodoFilter.displayCount {
                    countList[filter.rawValue] = count
                } else {
                    countList.append(count)
                }
                rootView.collectionView.reloadItems(at: [IndexPath(row: filter.rawValue, section: 0)])
            }
        }
    }
    
    @objc func calendarFilterClicked() {
        let vc = MainCalendarFilterViewController()
        presentNavigationController(view: vc, presentationStyle: .fullScreen, animated: true)
    }
    
    @objc func settingButtonClicked() {
        print(#function)
    }
}

extension MainViewController: MainViewDelegate {
    
    func goAddTodoViewController() {
        let nextVC = AddTodoViewController()
        nextVC.delegate = self
        self.presentNavigationController(view: nextVC, presentationStyle: nil, animated: true)
    }
    
    func goTodoListViewController() {
        let nextVC = TodoListViewController()
        pushViewController(view: nextVC, backButton: true, animated: true)
    }
    
}
