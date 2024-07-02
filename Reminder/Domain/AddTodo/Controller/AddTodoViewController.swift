//
//  AddTodoViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


class AddTodoViewController: BaseViewController<AddTodoView> {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationbar()
    }
    
    override func configNavigationbar() {
        super.configNavigationbar()
        let leftBarbuttonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancleAddTodo))
        let rightBarbuttonITem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(excuteAddTodo))
        rightBarbuttonITem.tintColor = .lightGray
        navigationItem.leftBarButtonItem = leftBarbuttonItem
        navigationItem.rightBarButtonItem = rightBarbuttonITem
        navigationItem.title = "새로운 할 일"
    }
    
    override func configInteraction() {
        rootView.titleTextField.delegate = self
        rootView.contentsTextView.delegate = self
    }
    
    @objc func cancleAddTodo() {
        dismiss(animated: true)
    }
    
    @objc func excuteAddTodo() {
        print(#function)
    }
}
