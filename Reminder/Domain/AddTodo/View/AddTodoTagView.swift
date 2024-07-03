//
//  AddTodoTagView.swift
//  Reminder
//
//  Created by 유철원 on 7/3/24.
//

import UIKit
import SnapKit
import Then


final class AddTodoTagView: BaseView {
    
    var delegate: AddTodoTagViewDelegate?
    
    let tagTextField = UITextField().then {
        $0.placeholder = "사용할 태그를 입력하세요"
        $0.setPlaceholder(color: .lightGray)
        $0.backgroundColor = .gray
        $0.tintColor = .lightGray
        $0.textColor = .systemGray5
    }
    
    let sendButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.tintColor = .lightGray
        $0.backgroundColor = .gray
    }
    
    override func configHierarchy() {
        self.addSubview(tagTextField)
        self.addSubview(sendButton)
    }
    
    override func configLayout() {
        tagTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview().offset(-20)
        }
        
        sendButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(100)
            $0.top.equalTo(tagTextField.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func configView() {
        self.backgroundColor = .darkGray
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
    }
    
    @objc func sendButtonClicked() {
        print(#function)
        guard let delegate else {
            print(#function, "DataReceiveDelegate 미설정")
            return
        }
        delegate.sendTagData()
    }
}
