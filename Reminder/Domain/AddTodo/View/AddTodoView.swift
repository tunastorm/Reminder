//
//  AddTodoView.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import SnapKit
import Then


class AddTodoView: BaseView {
    
    let titleContentsView = UIView().then {
        $0.backgroundColor = .systemGray3
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
    }
    let deadlineView = AddTodoItem()
    let tagView = AddTodoItem()
    let priorityView = AddTodoItem()
    let addImageView = AddTodoItem()
    
    
    override func configHierarchy() {
        self.addSubview(titleContentsView)
        self.addSubview(deadlineView)
        self.addSubview(tagView)
        self.addSubview(priorityView)
        self.addSubview(addImageView)
    }
    
    override func configLayout() {
        titleContentsView.snp.makeConstraints {
            $0.height.equalTo(180)
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        deadlineView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(titleContentsView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        tagView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(deadlineView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        priorityView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(tagView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        addImageView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(priorityView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func configView() {
        super.configView()
        titleContentsView.backgroundColor = .red
    }
}
