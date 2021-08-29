//
//  ExploreCardTableViewCellTests.swift
//  ANF Code TestTests
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import XCTest
import Combine
@testable import ANF_Code_Test

class ExploreCardTableViewCellTests: XCTestCase {
  var vc: ANFExploreCardTableViewController!
  var subscribe: AnyCancellable?
  var expectation: XCTestExpectation?
  
  override func setUp() {
    vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as? ANFExploreCardTableViewController
      let anfVM = ANFExploreCardViewModel()
      vc.set(anfVM)
      anfVM.dataSource = [ExploreCardCellModel(product: Product(title: "Test1", backgroundImage: "ImageName.jpg", content: [], promoMessage: "USE CODE: 12334", topDescription: "For testing", bottomDescription: "Testing bottom description")), ExploreCardCellModel(product: Product(title: "Test2", backgroundImage: "anf-20160527-app-m-shirts.jpg", content: [], promoMessage: "USE CODE: 12334", topDescription: "For testing", bottomDescription: "Testing bottom description"))]
  }
  
  func testSetViewModel() {
    let testInstance = createCell(at: 0)
    XCTAssertIdentical(testInstance?.viewModel, vc.viewModel.dataSource.first)
  }
  
  func testLabelConfigure() {
    let testInstance = createCell(at: 0)
    XCTAssertEqual(testInstance?.title?.text, "Test1")
  }
  
  func testImageConfigure() {
    let testInstance = createCell(at: 1)
    XCTAssertNotNil(testInstance?.productImage?.image)
  }
  
  func createCell(at row: Int) -> ExploreCardTableViewCell? {
    return vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: row, section: 0)) as? ExploreCardTableViewCell
  }
}
