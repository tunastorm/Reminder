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
}
