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


class AddTodoTagViewController: BaseViewController<AddTodoTagView> {
    
    var delegate: DataReceiveDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.delegate = self
        rootView.tagTextField.delegate = self
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
        let title = TextInputFilter().removeSpace(text)
        if textField == rootView.tagTextField && !TextInputFilter().filterSerialSpace(text) {
            textField.placeholder = "사용할 태그를 입력하세요"
        }
        return true
    }
}

extension AddTodoTagViewController: AddTodoTagViewDelegate {
    func sendTagData() {
        guard let text = rootView.tagTextField.text, let filterd = TextInputFilter().removeSpace(text) else {
            print(#function, "공백텍스트")
            return
        }
        guard let delegate else {
            return
        }
        delegate.receiveData(data: filterd)
        dismiss(animated: true)
    }
}
