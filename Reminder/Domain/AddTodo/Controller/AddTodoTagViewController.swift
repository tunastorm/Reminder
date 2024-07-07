//
//  AddTodoTagViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/3/24.
//

import UIKit


protocol AddTodoTagViewDelegate {
    func sendTagData()
}


final class AddTodoTagViewController: BaseViewController<AddTodoTagView> {
    
    var delegate: DataReceiveDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.delegate = self
        rootView.tagTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationbar(bgColor: .darkGray)
    }
    
    override func configNavigationbar(bgColor: UIColor) {
        super.configNavigationbar(bgColor: bgColor)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sendTagData()
    }
}

extension AddTodoTagViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.placeholder = nil
        textField.text = nil
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == rootView.tagTextField {
            textField.placeholder = "사용할 태그를 입력하세요"
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            print(#function, "입력텍스트 없음")
            return true
        }
        
//        guard textField == rootView.tagTextField, let filtered = TextInputFilter().tagFilter(textField.text ?? "") else {
//            textField.placeholder = "사용할 태그를 입력하세요"
//            return true
//        }

        return true
    }
}

extension AddTodoTagViewController: AddTodoTagViewDelegate {
    func sendTagData() {
        print(#function, "하이하이")
        guard let text = rootView.tagTextField.text, let filtered = TextInputFilter().tagFilter(text) else {
            rootView.tagTextField.placeholder = "사용할 태그를 입력하세요"
            return
        }
        guard let delegate else {
            return
        }
        print(#function, "태그설정완료")
        delegate.receiveData(data: filtered)
//        popBeforeViewController(animated: true)
    }
}
