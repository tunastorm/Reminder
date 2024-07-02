//
//  TodoListTableViewCell.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import Then


class TodoListTableViewCell: BaseTableViewCell {
    
    let label = UILabel().then {
        $0.textColor = .white
    }
    
    override func configHierarchy() {
        contentView.addSubview(label)
    }
    
    override func configLayout() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
    override func configView() {
        super.configView()
    }
    
    func configCell(data: TodoModel) {
        label.text = data.title
    }
}



