//
//  Product.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/26/21.
//

import Foundation

struct Product: Codable {
  let title: String
  let backgroundImage: String
  let content: [Content]?
  let promoMessage: String?
  let topDescription: String?
  let bottomDescription: String?
}

struct Content: Codable {
  let elementType: String?
  let title: String
  let target: String
}
