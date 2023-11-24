//
//  UITableView+Extension.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/10/29.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_ cell: T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    }
}
