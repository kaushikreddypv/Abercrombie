//
//  CardDetailsViewModel.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import Foundation
import CoreGraphics

final class CardDetailsViewModel: ViewModel {
  let product: Product
  
  var imageName: String {
    product.backgroundImage
  }
  
  var title: String {
    product.title
  }
  
  var topDescription: String? {
    product.topDescription
  }
  
  var promoMessage: String? {
    product.promoMessage
  }
  
  var bottomDescription: String? {
    product.bottomDescription
  }
  
  var buttonList: [Content] {
    product.content ?? []
  }
  
  init(product: Product) {
    self.product = product
  }
  
  func calucualteHeightConstraint(size: CGSize, newWidth: CGFloat) -> CGFloat {
    guard size.width > 0 else { return 0 }
    return (newWidth * size.height) / size.width
  }
}
