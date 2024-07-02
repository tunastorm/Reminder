//
//  TodoListTableViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


extension TodoListViewController: UITableViewDelegate, UITableViewDataSource /*UITableViewDataSourcePrefetching*/ {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TodoListHeaderView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.identifier, for: indexPath) as? TodoListTableViewCell else {
            return UITableViewCell()
        }
        guard let data = list?[indexPath.row] else {
            return cell
        }
        
        cell.configCell(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let list else {
            return nil
        }
        print(#function, "swipe!!!!")
        let delete = UIContextualAction(style: .normal, title: "삭제") { action, view, complitionHandler in
            
            try! self.realm.write {
                self.realm.delete(list[indexPath.row])
            }
            self.fatchRealm()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        print(#function, "hi")
//    }
    
}
