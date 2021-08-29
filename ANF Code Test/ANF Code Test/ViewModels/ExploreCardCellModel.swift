//
//  ExploreCardCellModel.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/26/21.
//

import Foundation

final class ExploreCardCellModel: ViewModel {
  let product: Product

  var title: String {
    product.title
  }
  
  var imageName: String {
    product.backgroundImage
  }
  
  init(product: Product) {
    self.product = product
  }
}
