//
//  CardDetailsViewControllerTests.swift
//  ANF Code TestTests
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import XCTest
@testable import ANF_Code_Test

class CardDetailsViewControllerTests: XCTestCase {
  var testInstance: CardDetailsViewController!
  var viewModel = CardDetailsViewModel(product: Product(title: "Test1", backgroundImage: "ImageName.jpg", content: nil, promoMessage: "USE CODE: 12334", topDescription: "For testing", bottomDescription: "Testing bottom description"))
  
  override func setUp() {
    testInstance = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: String(describing: CardDetailsViewController.self)) as? CardDetailsViewController
    testInstance.set(viewModel)
  }
  
  func testSetViewModel() {
    XCTAssertIdentical(testInstance.viewModel, viewModel)
  }
  
  func testTitleLabelConfigure() {
    XCTAssertNotNil(testInstance.view)
    XCTAssertEqual(testInstance.titleLabel.text, viewModel.title)
  }
  
  func testTopDescriptionConfigure() {
    XCTAssertNotNil(testInstance.view)
    XCTAssertEqual(testInstance.topDescription.text, viewModel.topDescription)
  }
  
  func testBottomDescriptionConfigure() {
    XCTAssertNotNil(testInstance.view)
    XCTAssertEqual(testInstance.bottomDescription.text, viewModel.bottomDescription)
  }
  
  func testPromoMessageConfigure() {
    XCTAssertNotNil(testInstance.view)
    XCTAssertEqual(testInstance.promoMessage.text, viewModel.promoMessage)
  }
  
  func testContentStackConfigureWithNoButtonList() {
    XCTAssertNotNil(testInstance.view)
    XCTAssertTrue(testInstance.contentStack.arrangedSubviews.isEmpty)
  }
  
  func testContentStackCountWithButtonList() {
    let content = Content(elementType: nil, title: "Content Tiltle", target: "Target")
    let model = CardDetailsViewModel(product: Product(title: "Test1", backgroundImage: "ImageName.jpg", content: [content], promoMessage: "USE CODE: 12334", topDescription: "For testing", bottomDescription: "Testing bottom description"))
    testInstance.set(model)
    XCTAssertNotNil(testInstance.view)
    XCTAssertEqual(testInstance.contentStack.arrangedSubviews.count, 1)
  }
  
  func testContentStackConfigureWithButtonList() {
    let content = Content(elementType: nil, title: "Content Tiltle", target: "Target")
    let model = CardDetailsViewModel(product: Product(title: "Test1", backgroundImage: "ImageName.jpg", content: [content], promoMessage: "USE CODE: 12334", topDescription: "For testing", bottomDescription: "Testing bottom description"))
    testInstance.set(model)
    XCTAssertNotNil(testInstance.view)
    XCTAssertTrue(testInstance.contentStack.arrangedSubviews.first is UIButton)
  }
  
  func testContentStackConfigureTextWithButtonList() {
    let content = Content(elementType: nil, title: "Content Tiltle", target: "Target")
    let model = CardDetailsViewModel(product: Product(title: "Test1", backgroundImage: "ImageName.jpg", content: [content], promoMessage: "USE CODE: 12334", topDescription: "For testing", bottomDescription: "Testing bottom description"))
    testInstance.set(model)
    XCTAssertNotNil(testInstance.view)
    let button = testInstance.contentStack.arrangedSubviews.first as? UIButton
    XCTAssertEqual(button?.currentTitle, content.title)
  }
}
