//
//  UIViewController+Extension.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/11/4.
//

import Foundation
import UIKit

extension UIViewController {
    static func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self), bundle: nil)
    }
}
