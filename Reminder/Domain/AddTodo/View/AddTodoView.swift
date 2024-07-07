//
//  AddTodoView.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import SnapKit
import Then


final class AddTodoView: BaseView {
    
    var delegate: addTodoViewDelegate?
    
    var showAddImageView: (() -> Void)?
    
    private let titleContentsView = UIView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    let titleTextField = UITextField().then {
        $0.placeholder = "제목"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .systemGray5
        $0.setPlaceholder(color: .lightGray)
        $0.backgroundColor = .clear
    }
    
    private let lineview = UIView().then {
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
        $0.setButton.tag = 0
    }
    let tagView = AddTodoItem().then {
        $0.itemName.text = "태그"
        $0.setButton.tag = 1
    }
    let priorityView = AddTodoItem().then {
        $0.itemName.text = "우선순위"
        $0.setButton.tag = 2
    }
    let addImageView = AddTodoImageView().then {
        $0.itemName.text = "이미지 추가"
        $0.setButton.tag = 3
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
            $0.height.greaterThanOrEqualTo(40)
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
        deadlineView.setButton.addTarget(self, action: #selector(goInputViewController), for: .touchUpInside)
        tagView.setButton.addTarget(self, action: #selector(goInputViewController), for: .touchUpInside)
        priorityView.setButton.addTarget(self, action: #selector(goInputViewController), for: .touchUpInside)
        addImageView.setButton.addTarget(self, action: #selector(addImageViewClicked), for: .touchUpInside)
    }
    
    func configItem(todo: TodoModel, isEditView: Bool) {
        let minPriority = TodoModel.Column.PriortyLevel.low.rawValue
        let maxPriority = TodoModel.Column.PriortyLevel.high.rawValue
        
        if !isEditView {
            titleTextField.text = todo.title
            titleTextField.textColor = .systemGray5
        }
        
        if !isEditView, let contents = todo.contents {
           contentsTextView.text = contents
            contentsTextView.textColor = .systemGray5
        }
        if let deadline = todo.deadline {
            Utils.dateFormatter.dateFormat = "yyyy. M. d."
            deadlineView.selectedTextField.placeholder = Utils.dateFormatter.string(from: deadline)
        }
        if !todo.tag.isEmpty {
            tagView.selectedTextField.placeholder = "#\(todo.tag)"
        }
        if let priority = todo.priority, minPriority <= priority && priority <= maxPriority {
            print(#function, todo.priority)
            let krPriority = TodoModel.Column.priority.allLevels[priority-1].krLevel
            priorityView.selectedTextField.placeholder = krPriority
        }
        addImageView.itemName.text = "이미지"
        if !isEditView, let delegate, let image = delegate.loadImage() {
             configAddImageView(image: image)
        }
    }
    
    func editingToggle(isEditView: Bool, todo: TodoModel) {
        if !isEditView {
            configItem(todo: todo, isEditView: isEditView)
        }
    }
    
    func callCreateError(column: TodoModel.Column) {
        makeToast(column.CreateError, duration: 3.0, position: .bottom)
    }
    
    func configAddImageView(image: UIImage) {
        print(#function, image)
        addImageView.snp.makeConstraints {
            $0.bottom.greaterThanOrEqualTo(safeAreaLayoutGuide).inset(10)
        }
        addImageView.uploadedImageView.snp.updateConstraints {
            $0.height.lessThanOrEqualTo(380)
        }
        addImageView.uploadedImageView.image = image
//        print(#function,addImageView.uploadedImageView.image ?? <#default value#>)
    }
    
    @objc func goInputViewController(_ sender: UIButton) {
        guard let delegate else {
            return
        }
        switch sender.tag {
        case 0: delegate.pushViewWithType(type: AddTodoCalendarViewController.self, presentationStyle: .none, animated: true)
        case 1: delegate.pushViewWithType(type: AddTodoTagViewController.self, presentationStyle: .none, animated: true)
        case 2: delegate.pushViewWithType(type: AddTodoPriorityViewController.self, presentationStyle: .none, animated: true)
        default: return
        }
    }
    
    @objc func addImageViewClicked() {
        guard let delegate else {
            return
        }
        delegate.showImagePickerView()
    }
}
