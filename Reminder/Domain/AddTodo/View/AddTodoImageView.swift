//
//  AddTodoImageView.swift
//  Reminder
//
//  Created by 유철원 on 7/7/24.
//

import UIKit
import SnapKit
import Then


final class AddTodoImageView: BaseView {
    
    let topView = UIView()

    let itemName = UILabel().then {
        $0.textColor = .systemGray5
        $0.textAlignment = .left
    }
    
    let setButton = UIButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 0)
        $0.setImage(Resource.SystemImage.chevronRight, for: .normal)
        $0.tintColor = .systemGray5
    }
    
    let uploadedImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = false
    }
    
    override func configHierarchy() {
        self.addSubview(topView)
        topView.addSubview(itemName)
        topView.addSubview(setButton)
        self.addSubview(uploadedImageView)
       
    }
    
    override func configLayout() {
        topView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(5)
        }
        itemName.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(5)
            $0.verticalEdges.equalToSuperview()
        }
        setButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.trailing.verticalEdges.equalToSuperview()
        }
        uploadedImageView.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(0)
            $0.top.equalTo(topView.snp.bottom).offset(5)
            $0.bottom.horizontalEdges.equalToSuperview().inset(5)
        }
    }
    
    override func configView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = .gray
    }
}
