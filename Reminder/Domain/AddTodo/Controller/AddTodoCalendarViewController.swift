//
//  AddTodoDatePicker.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


final class AddTodoCalendarViewController: BaseViewController<AddTodoCalendarView> {
    
    var delegate: DataReceiveDelegate?
    
    var selectedDate: Date? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCalendar()
        reloadCalendarView(date: Date())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationbar(bgColor: .darkGray)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let selectedDate, let delegate else {
            return
        }
        delegate.receiveData(data: selectedDate)
    }
    
    func configCalendar() {
        rootView.calendarView.delegate = self
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        rootView.calendarView.selectionBehavior = dateSelection
    }
    
    func reloadCalendarView(date: Date?) {
        if date == nil {
            return
        }
        let calendar = Calendar.current
        rootView.calendarView.reloadDecorations(forDateComponents: [calendar.dateComponents([.year, .day, .month, .hour, .minute], from: date!)], animated: true)
    }
    
}

extension AddTodoCalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate  {
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents, let delegate else {
            return
        }
        selection.setSelected(dateComponents, animated: true)
        selectedDate = Calendar.current.date(from: dateComponents)
        guard let selectedDate else {
            return
        }
        reloadCalendarView(date: selectedDate)
    }
}
