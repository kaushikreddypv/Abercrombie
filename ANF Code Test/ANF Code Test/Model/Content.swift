//
//  Content.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import Foundation

struct Content: Codable {
  let elementType: String?
  let title: String
  let target: String
}

extension Content: Equatable {
  static func == (lhs: Content, rhs: Content) -> Bool {
    lhs.title == rhs.title && lhs.target == rhs.target
  }
}

