//
//  MainCollectionViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/4/24.
//

import UIKit


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TodoFilter.displayCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configCell(data: TodoFilter.allCases[indexPath.row] , count: countList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = TodoFilter.allCases[indexPath.row]
        print(#function, filter)
        let vc = TodoListViewController()
        vc.delegate = self
        vc.filter = filter
        pushViewController(view: vc, backButton: true, animated: true)
    }
}
