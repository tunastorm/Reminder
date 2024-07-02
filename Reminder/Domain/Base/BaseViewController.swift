//
//  BaseViewController.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


class BaseViewController<T:BaseView>: UIViewController {
        
    var rootView = T()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationbar()
    }
    
    func configNavigationbar() {
        navigationItem.backButtonTitle = nil
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
