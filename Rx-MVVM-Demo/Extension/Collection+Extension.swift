//
//  Collection+Extension.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/11/5.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
