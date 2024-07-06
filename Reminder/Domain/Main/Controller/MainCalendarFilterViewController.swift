//
//  MainCalendarFilterViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/6/24.
//

import UIKit
import FSCalendar


final class MainCalendarFilterViewController: BaseViewController<MainCalendarFilterView> {
    
    var selectedDate: Date?
    let dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCalendar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationbar(bgColor: .darkGray)
    }
    
    override func configNavigationbar(bgColor: UIColor) {
        super.configNavigationbar(bgColor: bgColor)
        let leftBarButtonItem = UIBarButtonItem(image: Resource.SystemImage.chevronLeft, style: .plain, target: self, action: #selector(leftBarButtonClicked))
        let rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func configCalendar() {
        rootView.calendarView.delegate = self
        rootView.calendarView.dataSource = self
    }

    @objc func leftBarButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func rightBarButtonClicked() {
        let vc = TodoListViewController()
        vc.filter = TodoFilter.date
        vc.date = selectedDate
        pushViewController(view: vc, backButton: true, animated: true)
    }
}

extension MainCalendarFilterViewController: FSCalendarDelegate, FSCalendarDataSource  {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(Utils.dateFormatter.string(from: date) + " 날짜가 선택되었습니다.")
        selectedDate = date
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.rowHeight = calendar.scope == .week ? bounds.height : view.bounds.height
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
