//
//  UIScrollView+Extension.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/11/10.
//

import Foundation
import UIKit

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
