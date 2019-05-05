//
//  SecureDataSource.swift
//  SwiftSecurity
//
//  Created by Bibin Jacob Pulickal on 04/05/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import UIKit

class SecureDataSource: NSObject, UITableViewDataSource {

    private let secureKey = "secureKey"

    var secureItems = [SecureItem]()
    var completion: (() -> Void)?

    func loadSecureItems() {
        if let data = KeychainWrapper.standard.data(forKey: secureKey),
            let secureItems = try? data.decoded() as [SecureItem] {
            self.secureItems = secureItems
            self.completion?()
        }
    }

    func storeSecureItems() {
        KeychainWrapper.standard.set(secureItems.data, forKey: secureKey)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secureItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeue(SecureTableViewCell.self, for: indexPath) { cell in
            cell.secureItem = secureItems[indexPath.row]
        }
    }

    func addDialogue() -> UIAlertController {
        let dialogue = UIAlertController(title: "Store Securely", message: "What would you like to store securely?", preferredStyle: .alert)
        dialogue.addTextField { (textField) in
            textField.placeholder   = "Key"
        }
        dialogue.addTextField { (textField) in
            textField.placeholder   = "Text"
        }
        dialogue.addAction(UIAlertAction(title: "Store", style: .cancel, handler: { [weak self] action in
            let secureItem = SecureItem(key: dialogue.textFields?.first?.text, value: dialogue.textFields?.last?.text)
            self?.secureItems.append(secureItem)
            self?.completion?()
        }))
        dialogue.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        return dialogue
    }
}
