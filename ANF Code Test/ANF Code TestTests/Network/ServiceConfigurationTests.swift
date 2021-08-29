//
//  ServiceConfigurationTests.swift
//  ANF Code TestTests
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import XCTest
@testable import ANF_Code_Test

class ServiceConfigurationTests: XCTestCase {
  var testInstance: ServiceConfiguration?
  
  override func setUp() {
    testInstance = ServiceConfiguration()
  }
  
  func testDefaultEnvironment() {
    XCTAssertEqual(testInstance?.currentEnvi, .dev)
  }
  
  func testConfigInitialization() {
    XCTAssertNotNil(testInstance?.serviceConfig)
  }
  
  func testCustomEnvironmnet() {
    testInstance = ServiceConfiguration(environment: .mock)
    XCTAssertEqual(testInstance?.currentEnvi, .mock)
  }
}
