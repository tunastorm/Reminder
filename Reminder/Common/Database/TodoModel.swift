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
        
        var krColumn: String {
            switch self {
            case .id:
                return "아이디"
            case .title:
                return "제목"
            case .contents:
                return "내용"
            case .deadline:
                return "마감일"
            case .tag:
                return "태그"
            case .priority:
                return "우선순위"
            case .isFlag:
                return "깃발"
            case .isComplete:
                return "완료여부"
            }
        }
        
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
        
        var inputErrorMessage: String {
            return "\(self.krColumn) 값이 없거나 유효하지 않습니다."
        }
        
        var updatePropertSuccessMessage: String {
            return "\(self.krColumn) 의 수정이 완료되었습니다."
        }
        
        var updatePropertyErrorMessage: String {
            return "\(self.krColumn) 의 수정에 실패하였습니다."
        }
    }
}


