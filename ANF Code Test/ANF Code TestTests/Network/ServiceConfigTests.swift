//
//  ServiceConfigTest.swift
//  ANF Code TestTests
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import XCTest
@testable import ANF_Code_Test

class ServiceConfigTests: XCTestCase {
  var testInstance: ServiceConfig?
  let bundle = Bundle(for: ServiceConfigTests.self)
  
  override func setUp() {
    let path = bundle.path(forResource: "MockConfig", ofType: "plist")
    testInstance =  ServiceConfig(bundlePath: path)
  }
  
  func testIntializationWithCorrectPlist() {
      XCTAssertNotNil(self.testInstance)
  }
  
  func testIntializationWithWrongFormatPlist() {
    testInstance =  ServiceConfig(bundlePath: bundle.path(forResource: "NoEnvironments", ofType: "plist"))
    XCTAssertNil(testInstance)
  }
  
  func testBaseURLCount() {
    XCTAssertEqual(testInstance?.baseUrls.count, 2)
  }

  func testBaseURLContentForMock() {
    XCTAssertEqual(testInstance?.baseUrls[.mock], "mockURL")
  }
  
  func testBaseURLContentForDev() {
    XCTAssertEqual(testInstance?.baseUrls[.dev], "devURL")
  }
}
