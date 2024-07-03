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
    func updateTodoList()
}


final class MainViewController: BaseViewController<MainView>, UpdateListDelegate {
 
    var listinfo: Results<TodoListModel>?
    
    var listVector: [Results<TodoModel>] = []
    
    var today: Date?
    
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
        let barButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(settingButtonClicked))
        navigationItem.rightBarButtonItem = barButton
    }
    
    override func configDataBase() {
        configToday()
        configListInfo()
        configTodoList()
    }
    
    override func configInteraction() {
        rootView.delegate = self
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        rootView.collectionView.register(MainCollectionViewCell.self,
                                         forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
    func configToday() {
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        today = Calendar.current.date(from: dateComponent)
    }
    
    func updateTodoList() {
        listVector[2] = realm.objects(TodoModel.self)
        rootView.collectionView.reloadItems(at: [IndexPath(row: 2, section: 0)])
        guard let today else {
            return
        }
        let todayList = realm.objects(TodoModel.self).where { $0.deadline == today}
        let plannedList = realm.objects(TodoModel.self).where { $0.deadline > today}
        let likedList = realm.objects(TodoModel.self).where { $0.isLike == true }
        
        listVector[0] = todayList
        rootView.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
        
        listVector[1] = plannedList
        rootView.collectionView.reloadItems(at: [IndexPath(row: 1, section: 0)])
    
        listVector[3] = likedList
        rootView.collectionView.reloadItems(at: [IndexPath(row: 3, section: 0)])
    }
    
    
    func configTodoList() {
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let today = Calendar.current.date(from: dateComponent)
        
        listVector.append(realm.objects(TodoModel.self).where { $0.deadline == today})
        rootView.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
        listVector.append(realm.objects(TodoModel.self).where { $0.deadline > today})
        rootView.collectionView.reloadItems(at: [IndexPath(row: 1, section: 0)])
        listVector.append(realm.objects(TodoModel.self))
        rootView.collectionView.reloadItems(at: [IndexPath(row: 2, section: 0)])
        listVector.append(realm.objects(TodoModel.self).where { $0.isLike == true })
        rootView.collectionView.reloadItems(at: [IndexPath(row: 3, section: 0)])
        
        print(#function, listVector)
    }
    
    func configListInfo() {
        listinfo = realm.objects(TodoListModel.self)
    }
    @objc func settingButtonClicked() {
        print(#function)
    }
}

extension MainViewController: MainViewDelegate {
    
    func goAddTodoViewController() {
        let nextVC = AddTodoViewController()
        nextVC.delegate = self
        self.navigationPresentView(view: nextVC, presentationStyle: nil, animated: true)
    }
    
    func goTodoListViewController() {
        let nextVC = TodoListViewController()
        pushAfterView(view: nextVC, backButton: true, animated: true)
    }
    
}
