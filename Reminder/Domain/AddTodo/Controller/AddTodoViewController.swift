//
//  AddTodoViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import PhotosUI


protocol addTodoViewDelegate {
    func checkIsEditView() -> Bool
    func pushViewWithType<T:UIViewController>(type: T.Type, presentationStyle: UIModalPresentationStyle?, animated: Bool)
    func showImagePickerView()
    func loadImage() -> UIImage?
    func receiveData<T>(data: T) 
}


final class AddTodoViewController: BaseViewController<AddTodoView> {
  
    var delegate: UpdateListDelegate?
    
    var listId: Int?
    
    var isEditView = true
    
    var todo = TodoModel() {
        didSet {
            rootView.configItem(todo: todo, isEditView: isEditView)
        }
    }
    
    var uploadedImage: UIImage? {
        didSet {
            guard let uploadedImage else {
                return
            }
            rootView.configAddImageView(image: uploadedImage)
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationbar(bgColor: .darkGray)
        rootView.editingToggle(isEditView: isEditView, todo: todo)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func configNavigationbar(bgColor: UIColor) {
        super.configNavigationbar(bgColor: bgColor)
        navigationItem.rightBarButtonItem?.isHidden = !isEditView
        navigationItem.leftBarButtonItem?.isHidden = !isEditView
        if isEditView {
            let leftBarbuttonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancleAddTodo))
            let rightBarbuttonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(excuteAddTodo))
            rightBarbuttonItem.tintColor = .lightGray
            navigationItem.leftBarButtonItem = leftBarbuttonItem
            navigationItem.rightBarButtonItem = rightBarbuttonItem
            navigationItem.title = "새로운 할 일"
        } else {
            let barButtonItem1 = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deleteTodo))
            let barButtonItem2 = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(updateTodo))
            barButtonItem1.tintColor = .lightGray
            barButtonItem2.tintColor = .systemBlue
            navigationItem.rightBarButtonItems = [barButtonItem1, barButtonItem2]
            navigationItem.title = "할일 상세"
        }
    }
    
    
    override func configInteraction() {
        rootView.delegate = self
        rootView.titleTextField.delegate = self
        rootView.contentsTextView.delegate = self
    }
    
    @objc func excuteAddTodo() {
        guard let text = rootView.titleTextField.text, Utils.textFilter.filterSerialSpace(text) else {
            rootView.callCreateError(column: TodoModel.Column.title)
            return
        }
        guard let tag = Utils.textFilter.removeSpace(todo.tag) else {
            rootView.callCreateError(column: TodoModel.Column.tag)
            return
        }
        print(#function, tag)
        todo.title = text
        todo.contents = Utils.textFilter.removeSpace(rootView.contentsTextView.text ?? "")
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
        guard let uploadedImage else {
            return
        }
        saveImageToDocument(image: uploadedImage, filename: String(describing: todo.id))
    }
    
    
    @objc func updateTodo() {
        guard let text = rootView.titleTextField.text, Utils.textFilter.filterSerialSpace(text) else {
            rootView.callCreateError(column: TodoModel.Column.title)
            return
        }
        guard let tag = Utils.textFilter.removeSpace(todo.tag) else {
            rootView.callCreateError(column: TodoModel.Column.tag)
            return
        }
        do {
            try realm.write {
                realm.create(TodoModel.self, update: .modified)
            }
            popBeforeViewController(animated: true)
        } catch {
            print(error)
        }
        guard let uploadedImage else {
            return
        }
        saveImageToDocument(image: uploadedImage, filename: String(describing: todo.id))
    }
    
    @objc func deleteTodo() {
        do {
            try realm.write {
                realm.delete(todo)
            }
            delegate?.configCountList()
            popBeforeViewController(animated: true)
        } catch {
            
        }
    }
    
    @objc func cancleAddTodo() {
        dismiss(animated: true)
    }
}

extension AddTodoViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
       
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            dismiss(animated: true)
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    guard let image = image as? UIImage else {
                        return
                    }
                    self.uploadedImage = image
                }
            }
        }
    }
}

extension AddTodoViewController: ViewTransitionDelegate, addTodoViewDelegate, DataReceiveDelegate {
  
    func checkIsEditView() -> Bool {
        return isEditView
    }
    
    func pushViewWithType<T:UIViewController>(type: T.Type, presentationStyle: UIModalPresentationStyle? = nil, animated: Bool) where T : UIViewController {
        print( self.self, #function)
        // 어떻게 추상화하면 좋을까.
        var nextVC: UIViewController?
        var backButton: UIBarButtonItem?
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
        print(#function, "오이")
        pushViewController(view: nextVC, backButton: true, animated: true)
    }
    
    func showImagePickerView() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 3
        config.filter = .any(of: [.screenshots, .images])
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func loadImage() -> UIImage? {
        return loadImageToDocument(filename: String(describing: todo.id))
    }
    
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
