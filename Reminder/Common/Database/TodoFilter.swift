//
//  TodoFilter.swift
//  Reminder
//
//  Created by 유철원 on 7/4/24.
//

import UIKit


enum TodoFilter: Int, CaseIterable {
    case today = 0
    case planned
    case all
    case flagged
    case completed
    case lowPriority
   
    
    var krName: String {
        switch self {
        case .today:
            return "오늘"
        case .planned:
            return "예정"
        case .all:
            return "전체"
        case .flagged:
            return "깃발 표시"
        case .completed:
            return "완료됨"
        case .lowPriority:
            return "우선순위 낮음"
        }
    }
    
    var image: UIImage {
        switch self {
        case .today:
            return UIImage(systemName: "calendar.badge.clock")!
        case .planned:
            return UIImage(systemName: "calendar")!
        case .all:
            return UIImage(systemName: "tray")!
        case .flagged:
            return UIImage(systemName: "flag.fill")!
        case .completed:
            return UIImage(systemName: "checkmark")!
        case .lowPriority:
            return UIImage(systemName: "arrow.down.circle")!
        }
    }
    
    var color: UIColor {
        switch self {
        case .today:
            return .systemBlue
        case .planned:
            return .systemRed
        case .all:
            return .systemGray
        case .flagged:
            return .systemYellow
        case .completed:
            return .systemGray4
        case .lowPriority:
            return .systemGreen
        }
    }
}
