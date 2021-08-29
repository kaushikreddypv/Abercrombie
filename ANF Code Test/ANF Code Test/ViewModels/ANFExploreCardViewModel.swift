//
//  ANFExploreCardViewModel.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/26/21.
//

import Foundation
import Combine

final class ANFExploreCardViewModel: ViewModel {
  @Published var dataSource: [ExploreCardCellModel] = []
  private var exploreService: ExploreService
  private var exploreCancellable: AnyCancellable?
  @Published var error: ANFError?
  
  init(exploreService: ExploreService = ExploreServiceImplementation()) {
    self.exploreService = exploreService
  }
  
  func fetchProducts() {
    exploreCancellable = exploreService.fetchExploreItems()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] result in
        guard case .failure(let error) = result else { return }
        self?.error = error
      }) { [weak self] products in
        self?.prepareDataSource(products)
      }
  }
  
  private func prepareDataSource(_ products: [Product]) {
    dataSource = products.map { ExploreCardCellModel(product: $0) }
  }
  
  func getCardDetailViewModel(_ index: Int) -> CardDetailsViewModel? {
    guard let cellModel = dataSource[safe: index] else { return nil }
    return CardDetailsViewModel(product: cellModel.product)
  }
}
