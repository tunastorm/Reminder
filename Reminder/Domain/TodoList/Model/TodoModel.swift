//
//  TodoModel.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import Foundation
import RealmSwift


class TodoModel: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var contents: String?
    @Persisted var deadline: Date?
    @Persisted var tag: String
    @Persisted var priority: Int
    @Persisted var imageId: Int?
    
    convenience init(id: Int, title: String, contents: String? = nil, deadline: Date? = nil, tag: String, priority: Int, imageId: Int? = nil) {
        self.init()
        self.id = id
        self.title = title
        self.contents = contents
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
        self.imageId = imageId
    }
    
    enum Column: String {
        case id
        case title
        case contents
        case deadline
        case tag
        case priority
        case imageId
    }
}


