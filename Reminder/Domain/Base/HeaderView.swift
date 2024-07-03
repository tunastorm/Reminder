//
//  HeaderView.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import SnapKit
import Then


final class HeaderView: BaseView {
    
    let headerLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 30)
        $0.textAlignment = .left
        $0.textColor = .systemBlue
    }
    
    override func configHierarchy() {
        self.addSubview(headerLabel)
    }
    
    override func configLayout() {
        headerLabel.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.equalToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview()
        }
    }
    
    override func configView() {
        self.backgroundColor = .black
        headerLabel.text = "전체"
    }
    
    func configHeaderLabel(title: String) {
        headerLabel.text = title
    }
}
 
