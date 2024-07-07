//
//  TodoListSearchController.swift
//  Reminder
//
//  Created by 유철원 on 7/8/24.
//

import UIKit
import RealmSwift


extension TodoListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.placeholder = nil
        searchBar.text = nil
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var filterArray: [NSPredicate] = []
        for item in TodoModel.Column.allCases {
            print(#function, item)
            if item == .title || item == .contents {
                let predicate = "\(item.rawValue) CONTAINS[c] '\(searchText)'"
                print(#function, "predicate: ", predicate)
                filterArray.append(NSPredicate(format:predicate))
            }
        }
        let compundPredicate = NSCompoundPredicate(type: .or, subpredicates: filterArray)
        let filtered = repository.searchCompoundedFilter(objet: object, sortKey: .deadline, compoundPredicate: compundPredicate) {
            switch filter {
            case .today: $0.deadline != nil && $0.deadline == today
            case .planned: $0.deadline != nil && $0.deadline > today
            case .flagged: $0.isFlag
            case .completed: $0.isComplete
            case .lowPriority: $0.priority == TodoModel.Column.PriortyLevel.low.rawValue
            case .date: $0.deadline != nil && $0.deadline == self.date
            default: $0.isComplete || !$0.isComplete
            }
        }
        list = searchText.isEmpty ? configList(sort: .deadline) : filtered
    }
}
