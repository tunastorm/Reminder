//
//  MainCollectionViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/4/24.
//

import UIKit


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let data = list?[indexPath.row] else {
            return cell
        }
        cell.configCell(data: data)
        return cell
    }
}
