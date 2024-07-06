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
    case date
   
    static let displayCount = 5
   
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
        case .date:
            return "날짜별"
        }
    }
    
    var image: UIImage {
        switch self {
        case .today:
            return Resource.SystemImage.calendarBadgeClock
        case .planned:
            return Resource.SystemImage.calendar
        case .all:
            return Resource.SystemImage.tray
        case .flagged:
            return Resource.SystemImage.flagFill
        case .completed:
            return Resource.SystemImage.checkmark 
        case .lowPriority:
            return Resource.SystemImage.arrowDownCircle
        case .date:
            return Resource.SystemImage.calendarBadgeCheckmark
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
        case .date:
            return .systemBrown
        }
    }
    
    enum Week: String, CaseIterable {
        case sun
        case mon
        case tues
        case wends
        case thirs
        case fri
        case satur
        
        var kr: String {
            switch self {
            case .sun:
                return "일"
            case .mon:
                return "월"
            case .tues:
                return "화"
            case .wends:
                return "수"
            case .thirs:
                return "목"
            case .fri:
                return "금"
            case .satur:
                return "토"
            }
        }
    }
}
