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
        var queryArray: [NSPredicate] = []
        for item in TodoModel.Column.allCases {
            print(#function, item)
            if item == .title || item == .contents {
                let predicate = "\(item.rawValue) CONTAINS[c] '\(searchText)'"
                print(#function, "predicate: ", predicate)
                queryArray.append(NSPredicate(format:predicate))
            }
        }
        let query = NSCompoundPredicate(type: .or, subpredicates: queryArray)
        let filtered = repository.searchCompoundedFilter(objet: object, sortKey: .deadline, filter: query)
        list = searchText.isEmpty ?
        repository.fetchAll(obejct: object, sortKey: .deadline) : filtered
    }
}
