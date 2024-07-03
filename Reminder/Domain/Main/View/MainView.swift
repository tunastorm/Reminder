//
//  MainView.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import SnapKit
import Then


final class MainView: BaseView {

    var delegate: MainViewDelegate?
    
    let headerView = HeaderView()
    
    lazy var collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout())
    private let layout = {
        let layout = UICollectionViewFlowLayout()
        let horizontalCount = CGFloat(2)
        let verticalCount = CGFloat(8)
        let lineSpacing = CGFloat(10)
        let itemSpacing = CGFloat(5)
        let inset = CGFloat(10)
        let width: Double = UIScreen.main.bounds.width - 80
        let height: Double =  UIScreen.main.bounds.height - 90.0
        layout.itemSize = CGSize(width: width / horizontalCount, height: height / verticalCount)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        return layout
    }
    
    private let buttonArea = UIView()
    private let addListButton = UIButton().then {
        $0.setTitle("목록 추가", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.tintColor = .white
    }
    private let addTodoButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        $0.setTitle("새로운 할일", for: .normal)
    }
    
    override func configHierarchy() {
        self.addSubview(headerView)
        self.addSubview(collectionView)
        self.addSubview(buttonArea)
        buttonArea.addSubview(addListButton)
        buttonArea.addSubview(addTodoButton)
    }
    
    override func configLayout() {
        headerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
 
        collectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        buttonArea.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.top.equalTo(collectionView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        addTodoButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(120)
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        addListButton.snp.makeConstraints {
            $0.height.equalTo(addTodoButton)
            $0.width.equalTo(80)
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func configView() {
        print(#function, "why")
        collectionView.backgroundColor = .clear
        addTodoButton.addTarget(self, action: #selector(goAddTodo), for: .touchUpInside)
    }
    
    @objc private func goTodoList() {
        guard let delegate else {
            return
        }
        delegate.goTodoListViewController()
    }
    
    @objc private func goAddTodo() {
        guard let delegate else {
            return
        }
        delegate.goAddTodoViewController()
    }
}
