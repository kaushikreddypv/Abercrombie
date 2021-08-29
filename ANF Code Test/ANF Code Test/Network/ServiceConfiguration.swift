//
//  CardDetailsViewModel.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import Foundation

struct ServiceConfiguration {
  let serviceConfig: ServiceConfig
  let currentEnvi: Environment
  
  init(environment: Environment = .mock) {
    guard let serviceConfig = ServiceConfig(bundlePath: Bundle.main.path(forResource: "Config", ofType: "plist")) else {
      fatalError("Missing Config file")
    }
    self.serviceConfig = serviceConfig
    self.currentEnvi = environment
  }
}

