//
//  CardDetailsViewModel.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import Foundation

public enum Environment: String {
    case prod
    case dev
    case mock
}

public final class ServiceConfig: CustomStringConvertible, Equatable {
  
  private(set) var baseUrls: [Environment: String]
  
  init(baseUrls: [Environment: String]) {
    self.baseUrls = baseUrls
  }
  
  public convenience init?(bundlePath: String?) {
    guard let path = bundlePath, path != "" else {
      return nil
    }
    guard let xml = FileManager.default.contents(atPath: path), let dict = try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil) as? [String: Any] else {
      return nil
    }
    
    guard let enviDict = dict["environments"] as? [String: String] else { return nil }
    
    let baseUrls = enviDict.reduce(into: [Environment: String]()) { (result, x) in
      if let key = Environment(rawValue: x.key) {
        result[key] = x.value
      }
    }
    
    // Initialize with parameters
    self.init(baseUrls: baseUrls)
  }
  
  public var description: String {
    var str = ""
    baseUrls.forEach { dict in
     str +=  "\(dict.key): \(dict.value), "
    }
    return str
  }
  
  public static func ==(lhs: ServiceConfig, rhs: ServiceConfig) -> Bool {
    return lhs.baseUrls == rhs.baseUrls
  }
}
