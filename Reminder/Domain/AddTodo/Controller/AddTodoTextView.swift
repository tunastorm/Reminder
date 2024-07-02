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
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        guard let text = textView.text else {
            print(#function, "입력텍스트 없음")
            return true
        }
        if textView == rootView.contentsTextView && !TextInputFilter().filterSerialSpace(text) {
            textView.text = "내용"
        }
        return true
    }
    
}
