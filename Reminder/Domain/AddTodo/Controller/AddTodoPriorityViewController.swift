//
//  AddTodoPriorityViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/3/24.
//

import UIKit


final class AddTodoPriorityViewController: BaseViewController<AddTodoPriorityView> {
    
    var delegate: addTodoViewDelegate?
    
    let pickerList = TodoModel.Column.priority.allLevels
    
    var selectedPriority: TodoModel.Column.PriortyLevel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.pickerView.delegate = self
        rootView.pickerView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationbar(bgColor: .darkGray)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let selectedPriority, let delegate else {
            return
        }
        if delegate.checkIsEditView() {
            delegate.receiveData(data: selectedPriority)
        } else {
            let repository = TodoRepository()
            repository.updateProperty {
                delegate.receiveData(data: selectedPriority)
            } completionHandler: { status, error in
                guard error == nil, let status else {
                    self.delegate?.callErrorMessage(error ?? .unexpectedError, .priority)
                    return
                }
                self.delegate?.callStatusMessage(status, .priority)
            }
        }
    }
}

extension AddTodoPriorityViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row].krLevel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerList[row])
        guard let delegate else {
            return
        }
        selectedPriority = pickerList[row]
    }
}
