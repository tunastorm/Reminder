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
        
        var title = filter.krName
        if filter == .date, let date {
            title = Utils.dateFormatter.string(from: date)
        }
        headerView.configHeaderLabel(title: title)
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
        cell.radioButton.tag = indexPath.row
        cell.radioButton.addTarget(self, action: #selector(updateIsComplete), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddTodoViewController()
        vc.isEditView = false
        vc.todo = list[indexPath.row]
        pushViewController(view: vc, backButton: true, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let flag = UIContextualAction(style: .normal, title: "깃발설정") {_,_,_ in 
            self.repository.updateProperty {
                self.list[indexPath.row].isFlag.toggle()
            } completionHandler: { status, error in
                guard error == nil, let status else {
                    makeBasicToast(message: "깃발 설정에 실패하였습니다.", duration: 3.0, position: .bottom)
                    return
                }
                self.delegate?.configCountList()
                self.fatchRealm()
            }
        }
        
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, complitionHandler in
            self.repository.updateProperty {
                self.realm.delete(self.list[indexPath.row])
            } completionHandler: { status, error in
                guard error == nil, let status else {
                    makeBasicToast(message: "할일 삭제에 실패하였습니다.", duration: 3.0, position: .bottom)
                    return
                }
                self.delegate?.configCountList()
                self.fatchRealm()
            }
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
