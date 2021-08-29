//
//  CardDetailsViewModelTests.swift
//  ANF Code TestTests
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import XCTest
@testable import ANF_Code_Test

class CardDetailsViewModelTests: XCTestCase {
  var testInstance: CardDetailsViewModel!
  let product = Product(title: "Test1", backgroundImage: "ImageName.jpg", content: nil, promoMessage: "USE CODE: 12334", topDescription: "For testing", bottomDescription: "Testing bottom description")
  
  override func setUp() {
    testInstance = CardDetailsViewModel(product: product)
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
  
  func testTopDescriptionValue() {
    XCTAssertEqual(testInstance.topDescription, product.topDescription)
  }
  
  func testPromoMessageValue() {
    XCTAssertEqual(testInstance.promoMessage, product.promoMessage)
  }
  
  func testBottomDescriptionValue() {
    XCTAssertEqual(testInstance.bottomDescription, product.bottomDescription)
  }
  
  func testButtonListValueIfProductContentNil() {
    XCTAssertNotNil(testInstance.buttonList)
  }
  
  func testButtonListValueIfProductContentHasValue() {
    let content = Content(elementType: nil, title: "Content Tiltle", target: "Target")
    let model = CardDetailsViewModel(product: Product(title: "Test1", backgroundImage: "ImageName.jpg", content: [content], promoMessage: "USE CODE: 12334", topDescription: "For testing", bottomDescription: "Testing bottom description"))
    XCTAssertEqual(model.buttonList.first, content)
  }
  
  func testCalculateHeightForNonZeroOriginalSize() {
    let height = testInstance.calucualteHeightConstraint(size: CGSize(width: 1000, height: 599), newWidth: 414)
    XCTAssertEqual(height, 247.986)
  }
  
  func testCalculateHeightForZeroOriginalSize() {
    let height = testInstance.calucualteHeightConstraint(size: .zero, newWidth: 414)
    XCTAssertEqual(height, 0.0)
  }
}
