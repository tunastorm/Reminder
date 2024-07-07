//
//  MainCollectionViewCell.swift
//  Reminder
//
//  Created by 유철원 on 7/4/24.
//

import UIKit
import SnapKit
import Then


final class MainCollectionViewCell: BaseCollectionViewCell {
    
    
    let iconView = UIView().then {
        $0.layer.masksToBounds = true
    }
    
    let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    let nameLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .gray
        $0.textAlignment = .left
    }
    
    let countLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 30)
        $0.textAlignment = .right
        $0.textColor = .white
    }
    
    
    override func configHierarchy() {
        contentView.addSubview(iconView)
        iconView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
    }
    
    override func configLayout() {
        iconView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.top.leading.equalToSuperview().inset(10)
        }
        iconImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.greaterThanOrEqualTo(iconView.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalToSuperview().inset(10)
        }
        countLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.trailing.equalToSuperview().inset(10)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
    }
    
    override func draw(_ rect: CGRect) {
        iconView.layer.cornerRadius = iconView.frame.height * 0.5
    }
    
    override func configView() {
        contentView.backgroundColor = .darkGray
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    func configCell(data: TodoFilter, count: Int) {
        iconView.backgroundColor = data.color
        iconImageView.image = data.image
        nameLabel.text = data.krName
        guard count > 0 else {
            print(#function, "guard 탈락",data)
            countLabel.text = ""
            return
        }
        print(#function, "guard 통과", data)
        countLabel.text = String(count)
        print(#function, data, countLabel.text)
    }
}
