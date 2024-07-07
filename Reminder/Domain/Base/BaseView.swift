//
//  BaseView.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


class BaseView: UIView {
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configHierarchy()
        configLayout()
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configHierarchy() {
        
    }
    
    func configLayout() {
        
    }
    
    func configView() {
        self.backgroundColor = .black
    }
    
    func callRepositoryError(_ error: RepositoryError, _ column: TodoModel.Column? = nil) {
        if error == .updatedFailed, let column {
            makeToast(column.updatePropertyErrorMessage, duration: 3.0, position: .bottom)
        } else {
            makeToast(error.message, duration: 3.0, position: .bottom)
        }
    }
    
    func callRepositoryStatus(_ status: RepositoryStatus, _ column: TodoModel.Column? = nil) {
        if status == .updateSuccess, let column {
            makeToast(column.updatePropertSuccessMessage, duration: 3.0, position: .bottom)
        } else {
            makeToast(status.message, duration: 3.0, position: .bottom)
        }
    }
}
