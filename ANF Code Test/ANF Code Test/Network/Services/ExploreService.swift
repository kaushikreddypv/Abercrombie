//
//  ExploreService.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/26/21.
//

import Foundation
import Combine

protocol ExploreService: Service {
  func fetchExploreItems() -> Future<[Product], ANFError>
}

struct APIError: Error, Codable {
  let code: String
  let message: String
}

class ExploreServiceImplementation: ExploreService {
  private(set) var configuration: ServiceConfiguration
  
  func fetchExploreItems() -> Future<[Product], ANFError> {
    return Future() { [weak self] promise in
      self?.request(.exploreCards) { result in
        switch result {
        case .success(let data):
          guard let data = data else {
            promise(.failure(ANFError.parseFailed(reason: .dataNotFound)))
            return
          }
          do {
            let products = try JSONDecoder().decode([Product].self, from: data)
            promise(.success(products))
          } catch {
            promise(.failure(ANFError.parseFailed(reason: .formInvalid)))
          }
        case .failure(let error):
          promise(.failure(error))
        }
      }
    }
  }
  
  required init(serviceConfiguration: ServiceConfiguration = ServiceConfiguration()) {
    self.configuration = serviceConfiguration
  }
}
