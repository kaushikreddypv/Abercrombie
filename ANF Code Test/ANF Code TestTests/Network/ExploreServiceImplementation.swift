//
//  ExploreServiceImplementationTests.swift
//  ANF Code TestTests
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import XCTest
import Combine
@testable import ANF_Code_Test

class ExploreServiceImplementationTests: XCTestCase {
  var testInstance: ExploreService?
  var subscribe: AnyCancellable?
  
  override func setUp() {
    testInstance = ExploreServiceImplementation()
  }
  
  func testNetworkAPICall() {
    let expectation = self.expectation(description: "Wait for export data service call to succeed")
    testInstance?.request(.exploreCards, completion: { result in
      expectation.fulfill()
      XCTAssertNotNil(result.value ?? nil)
    })
    wait(for: [expectation], timeout: 5)
  }
  
  func testMockAPICall() {
    testInstance = ExploreServiceImplementation(serviceConfiguration: ServiceConfiguration(environment: .mock))
    let expectation = self.expectation(description: "Wait for export mock service call to succeed")
    testInstance?.request(.exploreCards, completion: { result in
      expectation.fulfill()
      XCTAssertNotNil(result.value ?? nil)
    })
    wait(for: [expectation], timeout: 5)
  }
  
  func testFetchExploreCardsParsingLogic() {
    testInstance = ExploreServiceImplementation(serviceConfiguration: ServiceConfiguration(environment: .mock))
    let expectation = self.expectation(description: "Wait for export mock service call to succeed")
    subscribe = testInstance?.fetchExploreItems()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { result in
        guard case .failure = result else { return }
        XCTFail("Error occurred while parsing data")
      },  receiveValue: { products in
        XCTAssertNotNil(products)
        expectation.fulfill()
        self.subscribe?.cancel()
      })
    wait(for: [expectation], timeout: 5)
  }
}
