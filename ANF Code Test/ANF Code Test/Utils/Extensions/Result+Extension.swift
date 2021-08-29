//
//  Result+Extension.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/28/21.
//

import Foundation

extension Result {
  var value: Success? {
    guard case .success(let value) = self else {
      return nil
    }
    return value
  }
  
  var error: Failure? {
    guard case .failure(let error) = self else {
      return nil
    }
    return error
  }
}
