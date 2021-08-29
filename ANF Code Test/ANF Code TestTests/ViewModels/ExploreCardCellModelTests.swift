//
//  ExploreCardCellModelTests.swift
//  ANF Code TestTests
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import XCTest
@testable import ANF_Code_Test

class ExploreCardCellModelTests: XCTestCase {
  var testInstance: ExploreCardCellModel!
  let product = Product(title: "Test1", backgroundImage: "ImageName.jpg", content: [], promoMessage: "USE CODE: 12334", topDescription: "For testing", bottomDescription: "Testing bottom description")
  
  override func setUp() {
    testInstance = ExploreCardCellModel(product: product)
  }
  
  func testInitializationOfProductVariable() {
    XCTAssertEqual(testInstance.product, product)
  }
  
  func testTitleVlaue() {
    XCTAssertEqual(testInstance.title, product.title)
  }
  
  func testImageNameValue() {
    XCTAssertEqual(testInstance.imageName, product.backgroundImage)
  }
}
