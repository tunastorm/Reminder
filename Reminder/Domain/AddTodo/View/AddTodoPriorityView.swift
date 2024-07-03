//
//  AddTodoPriorityView.swift
//  Reminder
//
//  Created by 유철원 on 7/3/24.
//

import UIKit
import SnapKit
import Then


final class AddTodoPriorityView: BaseView {
    
    let label = UILabel().then {
        $0.text = "설정할 우선순위를 선택하세요"
        $0.textColor = .systemGray5
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    let pickerView = UIPickerView()
    
    
    override func configHierarchy() {
        self.addSubview(label)
        self.addSubview(pickerView)
    }
    override func configLayout() {
        label.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.centerY.equalToSuperview().offset(-80)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        pickerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(label.snp.bottom).offset(-50)
        }
    }
    override func configView() {
        self.backgroundColor = .darkGray
    }
}
