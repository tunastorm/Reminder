//
//  BaseCollectionViewCell.swift
//  Reminder
//
//  Created by 유철원 on 7/4/24.
//

import UIKit


class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configHierarchy()
        configLayout()
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configHierarchy() {
       
    }
    
    func configLayout() {
        
    }
    
    func configView() {
        
    }
}
