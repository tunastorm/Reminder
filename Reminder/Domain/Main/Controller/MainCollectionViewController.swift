//
//  MainCollectionViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/4/24.
//

import UIKit


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listVector.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let listinfo = listinfo?[indexPath.row] else {
            return cell
        }
        cell.configCell(data: listinfo, count: listVector[indexPath.row].count)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TodoListViewController()
        vc.headerName = listinfo?[indexPath.row].listName
        vc.list = listVector[indexPath.row]
        pushAfterView(view: vc, backButton: true, animated: true)
    }
}
