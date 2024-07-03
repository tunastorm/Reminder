//
//  AddTodoDatePicker.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


class AddTodoCalendarViewController: BaseViewController<AddTodoCalendarView> {
    
    var delegate: DataReceiveDelegate?
    
    var selectedDate: DateComponents? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCalendar()
        reloadCalendarView(date: Date())
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
        selectedDate = dateComponents
        let date = Calendar.current.date(from: dateComponents)
        reloadCalendarView(date: date)
        delegate.receiveData(data: date)
        dismiss(animated: true)
    }
}
