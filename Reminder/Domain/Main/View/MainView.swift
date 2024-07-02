//
//  MainView.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import SnapKit
import Then


class MainView: BaseView {
    
    var delegate: MainViewDelegate?
    
    let buttonArea = UIView()
    let goTodoListButton = UIButton().then {
        $0.setTitle("목록", for: .normal)
        $0.backgroundColor = .lightGray
        $0.tintColor = .white
    }
    let addTodoButton = UIButton().then {
        $0.setTitle("새로운 할일", for: .normal)
        $0.backgroundColor = .lightGray
        $0.tintColor = .white
    }
    
    override func configHierarchy() {
        self.addSubview(buttonArea)
        buttonArea.addSubview(goTodoListButton)
        buttonArea.addSubview(addTodoButton)
    }
    
    override func configLayout() {
        buttonArea.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.center.equalToSuperview()
        }
        goTodoListButton.snp.makeConstraints {
            $0.height.equalTo(45)
            $0.top.horizontalEdges.equalToSuperview()
        }
        addTodoButton.snp.makeConstraints {
            $0.height.equalTo(45)
            $0.top.equalTo(goTodoListButton.snp.bottom).offset(10)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    override func configView() {
        goTodoListButton.addTarget(self, action: #selector(goTodoList), for: .touchUpInside)
        addTodoButton.addTarget(self, action: #selector(goAddTodo), for: .touchUpInside)
    }
    
    @objc func goTodoList() {
        guard let delegate else {
            return
        }
        delegate.goTodoListViewController()
    }
    
    @objc func goAddTodo() {
        guard let delegate else {
            return
        }
        delegate.goAddTodoViewController()
    }
}
