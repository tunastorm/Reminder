//
//  AddTodoInPut.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


class AddTodoItem: BaseView {
    let conatiner = UIView()
    
    let itemName = UILabel()
    
    override func configHierarchy() {
        
    }
    
    override func configLayout() {
        
    }
    
    override func configView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = .blue
    }
}
