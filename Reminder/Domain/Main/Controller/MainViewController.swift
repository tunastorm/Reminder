//
//  MainViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


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
        
}

extension MainViewController: MainViewDelegate {
    
    func goAddTodoViewController() {
        let nextVC = AddTodoViewController()
        navigationPresentAfterView(view: nextVC, style: .automatic, animated: true)
    }
    
    func goTodoListViewController() {
        let nextVC = TodoListViewController()
        pushAfterView(view: nextVC, backButton: true, animated: true)
    }
    
}

