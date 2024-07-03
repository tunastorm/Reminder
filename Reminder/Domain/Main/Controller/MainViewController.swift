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


final class MainViewController: BaseViewController<MainView>{
    
    var list: Results<TodoListModel>? {
        didSet {
            rootView.collectionView.reloadData()
        }
    }
    
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
        configTodoList()
        print(#function, list)
    }
    
    override func configInteraction() {
        rootView.delegate = self
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        rootView.collectionView.register(MainCollectionViewCell.self,
                                         forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
    func configTodoList() {
        do {
            try realm.write {
                list = realm.objects(TodoListModel.self)
            }
            
        } catch {
            makeBasicToast(message: "목록을 불러오지 못햇습니다. 고객센터로 문의하세요.", duration: 3.0, position: .bottom)
        }
        print(#function, list, list?.count)
        guard let list, list.count > 0 else {
            initialConfig()
            return
        }
    }
    
    func initialConfig() {
        print(#function, list)
        do {
            try realm.write {
                TodoListModel.defaultTodolist.forEach { list in
                    let todoList = TodoListModel(value: list)
                    realm.add(todoList)
                }
            }
            configTodoList()
        } catch {
            makeBasicToast(message: "초기 설정에 실패하였습니다. 고객센터로 문의하세요", duration: 3.0, position: .bottom)
        }
    }
    
    @objc func settingButtonClicked() {
        print(#function)
    }
}

extension MainViewController: MainViewDelegate {
    
    func goAddTodoViewController() {
        let nextVC = AddTodoViewController()
        navigationPresentView(view: nextVC, presentationStyle: nil, animated: true)
    }
    
    func goTodoListViewController() {
        let nextVC = TodoListViewController()
        pushAfterView(view: nextVC, backButton: true, animated: true)
    }
    
}

