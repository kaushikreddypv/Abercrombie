//
//  Collection.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/26/21.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
