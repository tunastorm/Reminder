//
//  AddTodoViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


final class AddTodoViewController: BaseViewController<AddTodoView> {
    
    var delegate: UpdateListDelegate?
    
    var listId: Int?
    
    var isEditView = true
    
    var todo = TodoModel() {
        didSet {
            rootView.configItem(todo: todo, isEditView: isEditView)
        }
    }
//    var deadline: Date?
//    var tag: String?
//    var priority: TodoModel.Column.PriortyLevel?
//    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationbar(bgColor: .darkGray)
        rootView.editingToggle(isEditView: isEditView, todo: todo)
    }
    
    override func configNavigationbar(bgColor: UIColor) {
        super.configNavigationbar(bgColor: bgColor)
        navigationItem.rightBarButtonItem?.isHidden = !isEditView
        navigationItem.leftBarButtonItem?.isHidden = !isEditView
        if isEditView {
            let leftBarbuttonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancleAddTodo))
            let rightBarbuttonITem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(excuteAddTodo))
            rightBarbuttonITem.tintColor = .lightGray
            navigationItem.leftBarButtonItem = leftBarbuttonItem
            navigationItem.rightBarButtonItem = rightBarbuttonITem
            navigationItem.title = "새로운 할 일"
        } else {
            navigationItem.title = todo.title
        }
    }
    
    
    override func configInteraction() {
        rootView.delegate = self
        rootView.titleTextField.delegate = self
        rootView.contentsTextView.delegate = self
    }
    
    @objc func excuteAddTodo() {
        let textFilter = TextInputFilter()
        guard let text = rootView.titleTextField.text, textFilter.filterSerialSpace(text) else {
            rootView.callCreateError(column: TodoModel.Column.title)
            return
        }
        guard let tag = textFilter.removeSpace(todo.tag) else {
            rootView.callCreateError(column: TodoModel.Column.tag)
            return
        }
        print(#function, tag)
        todo.title = text
        todo.contents = textFilter.removeSpace(rootView.contentsTextView.text ?? "")
        print(#function, todo)
        do {
            try realm.write {
                let todo = TodoModel(value: todo)
                realm.add(todo)
            }
            delegate?.configCountList()
            cancleAddTodo()
        } catch {
            print(error)
        }
    }
    
    @objc func cancleAddTodo() {
        dismiss(animated: true)
    }
}

extension AddTodoViewController: ViewTransitionDelegate {
  
    func presentViewWithType<T:UIViewController>(type: T.Type, presentationStyle: UIModalPresentationStyle? = nil, animated: Bool) where T : UIViewController {
        print( self.self, #function)
        // 어떻게 추상화하면 좋을까.
        var nextVC: UIViewController?
        switch T.self {
            case is AddTodoCalendarViewController.Type:
                let vc = T() as! AddTodoCalendarViewController
                vc.delegate = self
                nextVC = vc
            case is AddTodoTagViewController.Type:
                let vc = T() as! AddTodoTagViewController
                vc.delegate = self
                nextVC = vc
            case is AddTodoPriorityViewController.Type:
                let vc = T() as! AddTodoPriorityViewController
                vc.delegate = self
                nextVC = vc
            default: return
        }
        guard let nextVC else {
            print("nextVC 없음")
            return
        }
        presentView(view: nextVC, presentationStyle: presentationStyle, animated: animated)
    }
}

extension AddTodoViewController: DataReceiveDelegate {
    func receiveData<T>(data: T) {
        switch T.self{
        case is Date.Type: todo.deadline = data as! Date
        case is String.Type: todo.tag = data as! String
        case is TodoModel.Column.PriortyLevel.Type:
            let priority = data as! TodoModel.Column.PriortyLevel
            todo.priority = priority.rawValue
        default: return
        }
        rootView.configItem(todo: todo, isEditView: isEditView)
    }
}
