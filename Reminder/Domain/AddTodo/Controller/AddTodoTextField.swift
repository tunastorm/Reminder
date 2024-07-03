//
//  AddViewTextField.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


extension AddTodoViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.placeholder = nil
        textField.text = nil
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == rootView.titleTextField {
            textField.placeholder = "제목"
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            print(#function, "입력텍스트 없음")
            return true
        }
        guard textField == rootView.titleTextField, let filtered = TextInputFilter().removeSpace(text) else {
            textField.placeholder = "제목"
            return true
        }
        todo.title = filtered
        return true
    }
}

