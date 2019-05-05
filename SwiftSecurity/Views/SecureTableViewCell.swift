//
//  SecureTableViewCell.swift
//  SwiftSecurity
//
//  Created by Bibin Jacob Pulickal on 04/05/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import UIKit

class SecureTableViewCell: UITableViewCell {

    var secureItem: SecureItem? {
        didSet {
            textLabel?.text        = secureItem?.key
            detailTextLabel?.text  = secureItem?.value
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
