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


class MainViewController: BaseViewController<MainView>{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.delegate = self
        print(#function, realm.configuration.fileURL)
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
        } catch {
            
        }
    }
        
}

extension MainViewController: MainViewDelegate {
    
    func goAddTodoViewController() {
        let nextVC = AddTodoViewController()
        navigationPresentView(view: nextVC, style: .automatic, animated: true)
    }
    
    func goTodoListViewController() {
        let nextVC = TodoListViewController()
        pushAfterView(view: nextVC, backButton: true, animated: true)
    }
    
}

