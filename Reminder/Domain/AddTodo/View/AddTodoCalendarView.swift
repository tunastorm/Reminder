//
//  AddTodoCalanderView.swift
//  Reminder
//
//  Created by 유철원 on 7/3/24.
//

import UIKit

import SnapKit


final class AddTodoCalendarView: BaseView {
    
    lazy var calendarView: UICalendarView = {
        var view = UICalendarView()
        view.wantsDateDecorations = true
        return view
    }()
    
    override func configHierarchy() {
        self.addSubview(calendarView)
    }
    
    override func configLayout() {
        calendarView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
    override func configView() {
        self.backgroundColor = .darkGray
    }
    
}
