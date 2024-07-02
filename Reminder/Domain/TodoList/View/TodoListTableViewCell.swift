//
//  TodoListTableViewCell.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import SnapKit
import Then


class TodoListTableViewCell: BaseTableViewCell {
    
    let radioButton = UIButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 0)
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    let todoView = UIView()
    
    let highlightImage = UIImageView().then {
        $0.image = UIImage(systemName: "checkmarker")
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .left
    }
    
    let contentsLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .left
    }
    
    let deadlineLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .left
    }
    
    let tagLabel = UILabel().then {
        $0.textColor = .systemCyan
        $0.textAlignment = .left
        $0.font = .boldSystemFont(ofSize: 10)
    }
    
    
    override func configHierarchy() {
        contentView.addSubview(radioButton)
        contentView.addSubview(todoView)
        todoView.addSubview(highlightImage)
        todoView.addSubview(titleLabel)
        todoView.addSubview(contentsLabel)
        todoView.addSubview(deadlineLabel)
        todoView.addSubview(tagLabel)
    }
    
    override func configLayout() {
        radioButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(10)
        }
        todoView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalTo(radioButton.snp.trailing).offset(10)
            $0.verticalEdges.trailing.equalToSuperview().inset(10)
        }
        highlightImage.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.leading.equalTo(10)
            $0.top.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.leading.equalTo(highlightImage.snp.trailing).offset(10)
        }
        contentsLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(20)
        }
        deadlineLabel.snp.makeConstraints {
            $0.height.equalTo(contentsLabel)
            $0.width.equalTo(120)
            $0.top.equalTo(contentsLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
        tagLabel.snp.makeConstraints {
            $0.height.equalTo(deadlineLabel)
            $0.top.equalTo(contentsLabel.snp.bottom).offset(10)
            $0.leading.equalTo(deadlineLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configView() {
        super.configView()
//        radioButton.backgroundColor = .white
//        todoView.backgroundColor = .white
//        highlightImage.backgroundColor = .blue
//        titleLabel.backgroundColor = .blue
//        contentsLabel.backgroundColor = .blue
//        deadlineLabel.backgroundColor = .purple
//        tagLabel.backgroundColor = .red
    }
    
    func configCell(data: TodoModel) {
        titleLabel.text = data.title
    }
}



