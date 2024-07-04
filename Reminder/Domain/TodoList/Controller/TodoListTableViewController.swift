//
//  TodoListTableViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let filter else {
            return UIView()
        }
        let headerView = HeaderView()
        headerView.configHeaderLabel(title: filter.krName)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.identifier, for: indexPath) as? TodoListTableViewCell else {
            return UITableViewCell()
        }
        cell.configCell(data: list[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddTodoViewController()
        vc.isEditView = false
        vc.todo = list[indexPath.row]
        pushAfterView(view: vc, backButton: true, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, complitionHandler in
        
            try! self.realm.write {
                self.realm.delete(self.list[indexPath.row])
            }
            self.delegate?.configCountList()
            self.fatchRealm()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
