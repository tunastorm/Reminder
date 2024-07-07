//
//  TodoListTableViewCell.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import SnapKit
import Then


final class TodoListTableViewCell: BaseTableViewCell {
    
    let radioButton = UIButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 0)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    let todoView = UIView()
    
    let priorityLabel = UILabel().then {
        $0.isHidden = true
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .left
        $0.textColor = .systemBlue
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .left
    }
    let contentsLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 15)
        $0.textAlignment = .left
        $0.isHidden = true
    }
    let deadlineLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 15)
        $0.textAlignment = .left
        $0.isHidden = true
    }
    let tagLabel = UILabel().then {
        $0.textColor = .systemCyan
        $0.textAlignment = .left
        $0.font = .boldSystemFont(ofSize: 15)
    }
    
    
    override func configHierarchy() {
        contentView.addSubview(radioButton)
        contentView.addSubview(todoView)
        todoView.addSubview(priorityLabel)
        todoView.addSubview(titleLabel)
        todoView.addSubview(contentsLabel)
        todoView.addSubview(deadlineLabel)
        todoView.addSubview(tagLabel)
    }
    
    override func configLayout() {
        radioButton.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(10)
        }
        todoView.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(80)
            $0.leading.equalTo(radioButton.snp.trailing).offset(10)
            $0.verticalEdges.trailing.equalToSuperview().inset(10)
        }
        priorityLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(0)
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.leading.equalTo(priorityLabel.snp.trailing).offset(10)
        }
        contentsLabel.snp.makeConstraints {
            $0.height.equalTo(0)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(20)
        }
        deadlineLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(0)
            $0.top.equalTo(contentsLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        tagLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(contentsLabel.snp.bottom).offset(6)
            $0.leading.equalTo(deadlineLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configView() {
        super.configView()
    }
    
    func configCell(data: TodoModel) {
        print(#function, data)
        
        if let priority = data.priority {
            var a = ""
            for i in 1...priority {
                a += "!"
            }
            priorityLabel.text = a
            priorityLabel.isHidden = false
            priorityLabel.snp.updateConstraints {
                $0.width.equalTo(a.count * 8)
            }
        }
       
        // highlightImage 토글 로직 구현 필요
        if let contents = data.contents {
            contentsLabel.isHidden = false
            contentsLabel.text = data.contents
            contentsLabel.snp.updateConstraints {
                $0.height.equalTo(20)
                $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            }
        }
        if let deadline = data.deadline {
            Utils.dateFormatter.dateFormat = "yyyy. M. d."
            deadlineLabel.isHidden = false
            let dateString = Utils.dateFormatter.string(from: deadline)
            deadlineLabel.text = dateString
            deadlineLabel.snp.updateConstraints {
                $0.width.equalTo(dateString.count * 7)
                $0.leading.equalToSuperview().inset(10)
            }
        }
        titleLabel.text = data.title
        tagLabel.text = "#\(data.tag)"
        
    }
}



