//
//  AddTodoViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


class AddTodoViewController: BaseViewController<AddTodoView> {

    var deadline: Date?
    var tag: String?
    var priority: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationbar(bgColor: .darkGray)
    }
    
    override func configNavigationbar(bgColor: UIColor) {
        super.configNavigationbar(bgColor: bgColor)
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
        guard let tag else {
            return
        }
        guard let priority else {
            return
        }
        let contents: String? = rootView.contentsTextView.text
        let imageId: Int? = nil
        
        print(#function, "하이")
        do {
            try realm.write {
                let todo = TodoModel(title: text, contents: contents, deadline: deadline, tag: tag, priority: priority, imageId: imageId)
                realm.add(todo)
            }
            cancleAddTodo()
        } catch {
            print(error)
        }
    }
}

extension AddTodoViewController: ViewTransitionDelegate {
  
    func presentViewWithType<T:UIViewController>(type: T.Type, presentationStyle: UIModalPresentationStyle, animated: Bool) where T : UIViewController {
    
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
            return
        }
        presentView(view: nextVC, presentationStyle: presentationStyle, animated: animated)
    }
}

extension AddTodoViewController: DataReceiveDelegate {
    func receiveData<T>(data: T) {
        switch T.self{
        case is Date.Type: deadline = data as? Date
        case is String.Type: tag = data as? String
        case is Int.Type: priority = data as? Int
        default: return
        }
    }
}
