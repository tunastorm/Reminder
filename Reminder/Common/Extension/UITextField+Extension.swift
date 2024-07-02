//
//  UITextField+Extension.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


extension UITextField {
    func setPlaceholder(color: UIColor) {
            guard let string = self.placeholder else {
                return
            }
            attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
        }
}
