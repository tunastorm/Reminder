//
//  AddTodoInPut.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import SnapKit
import Then


class AddTodoItem: BaseView {

    let itemName = UILabel().then {
        $0.textColor = .systemGray5
        $0.textAlignment = .left
    }
    
    let setButton = UIButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 0)
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .systemGray5
    }
    
    let selectedTextField = UITextField().then {
        $0.backgroundColor = .clear
        $0.textAlignment = .right
        $0.setPlaceholder(color: .systemGray5)
        $0.isUserInteractionEnabled = false
    }
    
    override func configHierarchy() {
        self.addSubview(itemName)
        self.addSubview(selectedTextField)
        self.addSubview(setButton)
    }
    
    override func configLayout() {
        itemName.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.verticalEdges.equalToSuperview().inset(5)
        }
        
        selectedTextField.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.leading.equalTo(itemName.snp.trailing).offset(5)
        }
        
        setButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.leading.equalTo(selectedTextField.snp.trailing).offset(5)
            $0.trailing.verticalEdges.equalToSuperview().inset(5)
        }
    }
    
    override func configView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = .gray
    }
}
