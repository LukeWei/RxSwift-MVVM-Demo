//
//  Lenses.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/11/10.
//

import Foundation

protocol Mutable {}

extension Mutable {
    func mutate(transform: (inout Self) -> Void) -> Self {
        var newSelf = self
        transform(&newSelf)
        return newSelf
    }
}
