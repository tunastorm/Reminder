//
//  TodoModel.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import RealmSwift


final class TodoModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var contents: String?
    @Persisted var deadline: Date?
    @Persisted var tag: String
    @Persisted var priority: Int?
    @Persisted var isFlag: Bool
    @Persisted var isComplete: Bool
    
    convenience init(title: String, contents: String? = nil, deadline: Date? = nil, tag: String, priority: Int? = nil, isFlag: Bool = false, isComplete: Bool = false) {
        self.init()
        self.title = title
        self.contents = contents
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
        self.isFlag = isFlag
        self.isComplete = isComplete
    }
    
    enum Column: String, CaseIterable {
        case id
        case title
        case contents
        case deadline
        case tag
        case priority
        case isFlag
        case isComplete
        
        enum PriortyLevel: Int, CaseIterable {
            case low = 1
            case middle
            case high
            
            var krLevel: String {
                switch self {
                case .low:
                    return "낮음"
                case .middle:
                    return "중간"
                case .high:
                    return "높음"
                }
            }
        }
        
        var allLevels: [PriortyLevel] {
            return PriortyLevel.allCases
        }
        
        var CreateError: String {
            return "\(self)값이 없거나 유효하지 않습니다."
        }
    }
}


