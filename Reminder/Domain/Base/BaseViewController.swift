//
//  BaseViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import RealmSwift


class BaseViewController<T:BaseView>: UIViewController {
        
    var rootView = T()
    let realm = try! Realm()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDataBase()
        configInteraction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationbar(bgColor: .black)
    }
    
    func configNavigationbar(bgColor: UIColor) {
        navigationItem.backButtonTitle = ""
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = bgColor
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func configInteraction() {
        
    }
    
    func configDataBase() {
        
    }
    
    
    func showAlert(title: String,message: String, ok: String?, handler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var cancleTitle = "확인"
        if let okTitle = ok, let handler {
            cancleTitle = "취소"
            let ok = UIAlertAction(title: okTitle, style: .default) { _ in
                handler()
            }
            alert.addAction(ok)
        }
        let cancel = UIAlertAction(title: cancleTitle, style: .cancel)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func showActionAlert(titleList: [String], complitionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        // 2.
        
        var actionList: [UIAlertAction] = []
        titleList.forEach { title in
            let action = UIAlertAction(title: title, style: .default, handler: complitionHandler)
            actionList.append(action)
        }
        let cancle = UIAlertAction(title: "취소",
                                   style: .cancel)
        // 3. addAction 순서대로 좌->우, 상->하로 정렬
        // 하지만 UIAlertAction의 style 파라미터에 정의된 스타일에 지정된 위치가 우선한다.
        actionList.forEach { action in
            alert.addAction(action)
        }
        alert.addAction(cancle)
        // 4.
        present(alert, animated: false)
    }
}
