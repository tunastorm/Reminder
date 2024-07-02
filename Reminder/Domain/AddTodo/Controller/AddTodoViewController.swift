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
        guard let text = rootView.titleTextField.text, TextInputFilter().filterSerialSpace(text) else {
            rootView.inputErrorEvent()
            return
        }
        let contents: String? = rootView.contentsTextView.text
        let tag = "테스트"
        let priority = Int.random(in: 0...5)
        let imageId: Int? = nil
        
        print(#function, "하이")
        do {
            try realm.write {
                let todo = TodoModel(title: text, contents: contents, tag: tag, priority: priority, imageId: imageId)
                realm.add(todo)
            }
            cancleAddTodo()
        } catch {
            print(error)
        }
    }
}
