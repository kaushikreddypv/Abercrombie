//
//  ExploreService.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/26/21.
//

import Foundation
import Combine

protocol ExploreService {
  func fetchExploreItems() -> Future<[Product], Error>
}

struct APIError: Error, Codable {
  let code: String
  let message: String
}

class MockExploreService: ExploreService {
  func fetchExploreItems() -> Future<[Product], Error> {
    Future() { promise in
      guard let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
        promise(.failure(APIError(code: "-1", message: "Issue with Json")))
        return
      }
      do {
        let products = try JSONDecoder().decode([Product].self, from: data)
        promise(.success(products))
      } catch(let error) {
        promise(.failure(error))
      }
    }
  }
}
