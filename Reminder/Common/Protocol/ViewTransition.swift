//
//  ViewTransition.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit


protocol ViewTransition {
   
    func pushAfterView(view: UIViewController, backButton: Bool, animated: Bool)
    
    func presentView(view: UIViewController, presentationStyle: UIModalPresentationStyle, animated: Bool)
    
    func navigationPresentView(view: UIViewController, style: UIModalPresentationStyle, animated: Bool)
    
    func popBeforeView(animated: Bool)
   
    func popToBeforeView(_ view: UIViewController, animated: Bool)
    
    func popToRootView(animated: Bool)
}


extension UIViewController: ViewTransition {

    func pushAfterView(view: UIViewController, backButton: Bool, animated: Bool) {
        if !backButton {
            view.navigationItem.hidesBackButton = true
        }
        self.navigationController?.pushViewController(view, animated: animated)
    }
    
    func presentView(view: UIViewController, presentationStyle: UIModalPresentationStyle, animated: Bool) {
        view.modalPresentationStyle = presentationStyle
        self.present(view, animated: animated)
    }
    
    func navigationPresentView(view: UIViewController, style: UIModalPresentationStyle, animated: Bool) {
        let nav = UINavigationController(rootViewController: view)
        nav.modalPresentationStyle = style
        present(nav, animated: animated)
    }
    
    func popBeforeView(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToBeforeView(_ view: UIViewController, animated: Bool) {
        navigationController?.popToViewController(view, animated: animated)
    }
    
    func popToRootView(animated: Bool) {
        navigationController?.popToRootViewController(animated: true)
    }
}

protocol CellTransitionDelegate {
    
    func turnBackRootView()
    
    func pushAfterViewType<T: UIViewController>(type: T.Type, animated: Bool)
    
    func pushChangeSelectView()
    
    func popToRootViewFromCell(animated: Bool)
    
    func presentAlert(_ alert: UIAlertController, animated: Bool)
}
