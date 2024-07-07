//
//  AddToDoViewTextView.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


extension AddTodoViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView == rootView.contentsTextView {
            textView.text = nil
            textView.textColor = .systemGray5
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        guard textView == rootView.contentsTextView, let text = textView.text else {
            print(#function, "입력텍스트 없음")
            return true
        }
        guard let filterd = TextInputFilter().removeSpace(text) else {
            textView.text = "내용"
            textView.textColor = .lightGray
            return true
        }
        if isEditView {
            todo.contents = filterd
        } else {
            repository.updateProperty {
                todo.contents = filterd
            } completionHandler: { status, error in
                guard error == nil, let status else {
                    self.rootView.callRepositoryError(.updatedFailed, .contents)
                    return
                }
                self.rootView.callRepositoryStatus(.updateSuccess, .contents)
            }

        }
        return true
    }
}
