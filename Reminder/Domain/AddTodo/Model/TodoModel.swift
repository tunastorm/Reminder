//
//  TodoModel.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import Foundation
import RealmSwift


class TodoModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var contents: String?
    @Persisted var deadline: Date?
    @Persisted var tag: String
    @Persisted var priority: Int
    @Persisted var imageId: Int?
    
    convenience init(title: String, contents: String? = nil, deadline: Date? = nil, tag: String, priority: Int, imageId: Int? = nil) {
        self.init()
        self.title = title
        self.contents = contents
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
        self.imageId = imageId
    }
    
    enum Column: String, CaseIterable {
        case id
        case title
        case contents
        case deadline
        case tag
        case priority
        case imageId
        
        
        enum PriortyLevel: Int, CaseIterable {
            case unimportant = 1
            case changeable
            case planned
            case immediately
            case critical
            
            var krLevel: String {
                switch self {
                case .unimportant:
                    return "중요하지 않음"
                case .changeable:
                    return "유동적"
                case .planned:
                    return "계획됨"
                case .immediately:
                    return "즉시"
                case .critical:
                    return "필수"
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


