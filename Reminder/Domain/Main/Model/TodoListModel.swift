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
    @Persisted var todoCount: Int
    @Persisted var iconPath: String
    @Persisted var bgColor: Int
    let todos = List<TodoModel>()
    
    convenience init(listName: String, todoCount: Int, iconPath: String, bgColor: Int) {
        self.init()
        self.listName = listName
        self.todoCount = todoCount
        self.iconPath = iconPath
        self.bgColor = bgColor
    }
    
    enum Column: String {
        case id
        case listName
        case todoCount
        case icon
        case bgColor
        case todos
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
    
    
    static let defaultTodolist = [
        TodoListModel(listName: "오늘", todoCount: 0, iconPath: "calendar.badge.clock", bgColor: 2),
        TodoListModel(listName: "예정", todoCount: 0, iconPath: "calendar", bgColor: 3),
        TodoListModel(listName: "전체", todoCount: 0, iconPath: "tray", bgColor: 0),
        TodoListModel(listName: "깃발 표시", todoCount: 0, iconPath: "flag.fill", bgColor: 4),
        TodoListModel(listName: "완료됨", todoCount: 0, iconPath: "checkmark", bgColor: 1),
    ]
}
