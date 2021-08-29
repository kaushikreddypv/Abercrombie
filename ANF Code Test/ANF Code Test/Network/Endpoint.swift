//
//  CardDetailsViewModel.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import Foundation
import Alamofire

protocol EndPointType {
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: Parameters? { get }
}


enum EndPoint: EndPointType {
  case exploreCards
  
  // MARK: - HTTPMethod
  var method: HTTPMethod {
    switch self {
    case .exploreCards:
      return .get
    }
  }
  
  // MARK: - Path
  var path: String {
    switch self {
    case .exploreCards:
      return "codeTest_exploreData.json"
    }
  }
  
  var mockPath: String {
    switch self {
    case .exploreCards:
      return "exploreData"
    }
  }
  
  // MARK: - Parameters
  var parameters: Parameters? {
    return nil
  }
}
