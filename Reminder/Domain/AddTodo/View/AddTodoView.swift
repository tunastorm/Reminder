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
    
    var delegate: AddTodoViewDelegate?
    
    let titleContentsView = UIView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    let titleTextField = UITextField().then {
        $0.placeholder = "제목"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .lightGray
        $0.setPlaceholder(color: .lightGray)
        $0.backgroundColor = .clear
    }
    
    let lineview = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    let contentsTextView = UITextView().then {
        $0.text = "메모"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .lightGray
        $0.backgroundColor = .clear
    }
    
    let deadlineView = AddTodoItem().then {
        $0.itemName.text = "마감일"
    }
    let tagView = AddTodoItem().then {
        $0.itemName.text = "태그"
    }
    let priorityView = AddTodoItem().then {
        $0.itemName.text = "우선순위"
    }
    let addImageView = AddTodoItem().then {
        $0.itemName.text = "이미지 추가"
    }
    
    
    override func configHierarchy() {
        self.addSubview(titleContentsView)
        titleContentsView.addSubview(titleTextField)
        titleContentsView.addSubview(lineview)
        titleContentsView.addSubview(contentsTextView)
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
        titleTextField.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalToSuperview().inset(8)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        lineview.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(titleTextField.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        contentsTextView.snp.makeConstraints {
            $0.top.equalTo(lineview.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview().inset(8)
        }
    }
    
    override func configView() {
        self.backgroundColor = .darkGray
        deadlineView.setButton.addTarget(self, action: #selector(showCalendar), for: .touchUpInside)
        
    }
    
    func inputErrorEvent() {
        makeToast("제목을 입력해주세요", duration: 3.0, position: .center)
//        makeBasicToast(message: "제목을 입력해주세요", duration: 3.0, position: .center)
    }
    
    @objc func showCalendar() {
        guard let delegate else {
            
            return
        }
        delegate.presentCalendarView()
    }
}
