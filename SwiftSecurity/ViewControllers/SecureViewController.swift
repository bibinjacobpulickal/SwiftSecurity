//
//  SecureViewController.swift
//  SwiftSecurity
//
//  Created by Bibin Jacob Pulickal on 04/05/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import UIKit

class SecureViewController: UITableViewController {

    private let secureDataSource = SecureDataSource()

    override func loadView() {
        super.loadView()
        tableView.dataSource = secureDataSource
        tableView.register(SecureTableViewCell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        hideSecureData()
    }

    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(hideSecureData), name: UIApplication.willResignActiveNotification, object: nil)
    }

    @objc private func authenticate() {
        LAHelper().authenticate { [weak self] (success, error) in
            if success {
                self?.revealSecureData()
            } else {
                self?.showAlert(message: error?.localizedDescription)
            }
        }
    }

    @objc private func hideSecureData() {
        tableView.isHidden                  = true
        navigationItem.title                = "Secure Storage"
        navigationItem.rightBarButtonItem   = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(authenticate))
    }

    private func revealSecureData() {
        secureDataSource.loadSecureItems()
        secureDataSource.completion = { [weak self] in
            self?.tableView.reloadData()
        }
        tableView.isHidden                  = false
        navigationItem.rightBarButtonItem   = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSecureItem))
    }

    @objc private func addSecureItem() {
        let addDialogue = secureDataSource.addDialogue()
        present(addDialogue, animated: true)
    }
}

