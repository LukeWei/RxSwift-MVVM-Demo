//
//  UIImageView+Extension.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/11/5.
//

import Foundation
import UIKit
import RxSwift

extension UIImageView {
    /// Simple load image with URL.
    func loadFrom(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if let data = try? Data(contentsOf: url) {
            image = UIImage(data: data)
        }
    }
}
