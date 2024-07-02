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
        let barbuttonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancleAddTodo))
        navigationItem.leftBarButtonItem = barbuttonItem
    }
    
    @objc func cancleAddTodo() {
        dismiss(animated: true)
    }
}
