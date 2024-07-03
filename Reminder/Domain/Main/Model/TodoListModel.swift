//
//  TodoListModel.swift
//  Reminder
//
//  Created by 유철원 on 7/4/24.
//

import UIKit
import RealmSwift


class TodoListModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var listName: String
    @Persisted var iconPath: String
    @Persisted var bgColor: Int
    @Persisted var todoCount: Int
    
    convenience init(listName: String, iconPath: String, bgColor: Int, todoCount: Int) {
        self.init()
        self.listName = listName
        self.iconPath = iconPath
        self.bgColor = bgColor
        self.todoCount = todoCount
    }
    
    enum Column: String {
        case id
        case listName
        case icon
        case bgColor
        case todoCount
    }
    
    enum BackgroundColor: Int, CaseIterable {
        case systemGray = 0
        case systemGray4
        case systemBlue
        case systemRed
        case systemYellow

        var color: UIColor {
            switch self {
            case .systemGray:
                return .systemGray
            case .systemGray4:
                return .systemGray4
            case .systemBlue:
                return .systemBlue
            case .systemRed:
                return .systemRed
            case .systemYellow:
                return .systemYellow
            }
        }
    }
    
    var allColors: [BackgroundColor] {
        return BackgroundColor.allCases
    }
    
    
//    static let defaultTodolist = [
//        TodoListModel(listName: "오늘", iconPath: "calendar.badge.clock", bgColor: 2),
//        TodoListModel(listName: "예정", iconPath: "calendar", bgColor: 3),
//        TodoListModel(listName: "전체", iconPath: "tray", bgColor: 0),
//        TodoListModel(listName: "깃발 표시",  iconPath: "flag.fill", bgColor: 4),
//        TodoListModel(listName: "완료됨", iconPath: "checkmark", bgColor: 1),
//    ]
}
