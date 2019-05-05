//
//  UIViewControllerExtensions.swift
//  SwiftSecurity
//
//  Created by Bibin Jacob Pulickal on 04/05/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(
        title: String? = "Alert",
        message: String? = "Something went wrong!",
        action: ((UIAlertAction) -> Void)? = nil,
        completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OKAY", style: .default, handler: action))
        present(alert, animated: true, completion: completion)
    }
}
