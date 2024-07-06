//
//  AddTodoPriorityViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/3/24.
//

import UIKit


final class AddTodoPriorityViewController: BaseViewController<AddTodoPriorityView> {
    
    var delegate: DataReceiveDelegate?
    
    let pickerList = TodoModel.Column.priority.allLevels
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.pickerView.delegate = self
        rootView.pickerView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationbar(bgColor: .darkGray)
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
        delegate.receiveData(data: pickerList[row])
        popBeforeViewController(animated: true)
    }
}
