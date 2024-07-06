//
//  MainCalendarFilterView.swift
//  Reminder
//
//  Created by 유철원 on 7/6/24.
//

import UIKit
import FSCalendar


final class MainCalendarFilterView: BaseView {
    
    let calendarView = FSCalendar(frame: CGRect(x: 0, y: 0, width: 0, height:0))

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
        configFSCalendar()
    }
    
    func configFSCalendar() {
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.scope = .week
        calendarView.scrollEnabled = true
        calendarView.scrollDirection = .horizontal
        
        TodoFilter.Week.allCases.enumerated().forEach { idx, day in
            calendarView.calendarWeekdayView.weekdayLabels[idx].text = day.kr
        }
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(calendarSwiped))
        swipeUp.direction = .up
        calendarView.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(calendarSwiped))
        swipeDown.direction = .down
        calendarView.addGestureRecognizer(swipeDown)
    }
  
    @objc func calendarSwiped(_ swipe: UISwipeGestureRecognizer) {
        switch swipe.direction {
        case .up: calendarView.setScope(.week, animated: true)
        case .down: calendarView.setScope(.month, animated: true)
        default : return
        }
       
    }
//    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
//        calendar.snp.updateConstraints { (make) in
//            make.height.equalTo(bounds.height)
//            // Do other updates
//        }
//        self.layoutIfNeeded()
//    }
    
}
