//
//  ANFExploreCardViewModelTests.swift
//  ANF Code TestTests
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import XCTest
import Combine
@testable import ANF_Code_Test

class ANFExploreCardViewModelTests: XCTestCase {
  var testInstance: ANFExploreCardViewModel!
  var expectation: XCTestExpectation?
  var subscribe: AnyCancellable?
  
  override func setUp() {
    testInstance = ANFExploreCardViewModel()
    subscribe = testInstance.$dataSource
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] _ in
        self?.expectation?.fulfill()
      })
  }
  
  func testDataSourceCountAfterFetchProducts() {
    waitForFetchProducts {
      self.subscribe?.cancel()
      XCTAssertFalse(self.testInstance.dataSource.isEmpty)
      XCTAssertEqual(self.testInstance.dataSource.count, 10)
    }
  }
  
  func testDataSourceCountBeforeFetchProducts() {
    XCTAssertTrue(testInstance.dataSource.isEmpty)
  }
  
  func testGetCardDetailViewModelWithOutOfRangeIndex() {
    let cellViewModel = testInstance.getCardDetailViewModel(20)
    XCTAssertNil(cellViewModel)
  }
  
  func testGetCardDetailViewModelWithInRangeIndex() {
    waitForFetchProducts {
      let cellViewModel = self.testInstance.getCardDetailViewModel(6)
      XCTAssertNotNil(cellViewModel)
    }
  }
  
  func testGetCardDetailViewModelWithDataSource() {
    waitForFetchProducts {
      let index = 6
      let cellViewModel = self.testInstance.getCardDetailViewModel(index)
      XCTAssertEqual(cellViewModel?.product, self.testInstance.dataSource[index].product)
    }
  }
  
  func waitForFetchProducts(clouser: @escaping () -> Void) {
    expectation = self.expectation(description: "Wait for export card call to succeed")
    testInstance.fetchProducts()
    waitForExpectations(timeout: 5) { error in
      XCTAssertNil(error)
      self.subscribe?.cancel()
      clouser()
    }
  }
}
