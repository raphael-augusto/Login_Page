//
//  UIViewController.swift
//  Login
//
//  Created by Raphael Augusto on 05/08/22.
//

import UIKit

extension UIViewController {
    
    func presentGFAlert(title: String, message: String, buttonTitle:String) {
        let alertVC = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle  = .overFullScreen
        alertVC.modalTransitionStyle    = .crossDissolve

        present(alertVC, animated: true)
    }
    
}
