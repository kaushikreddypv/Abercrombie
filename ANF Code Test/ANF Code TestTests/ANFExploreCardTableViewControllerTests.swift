//
//  ANF_Code_TestTests.swift
//  ANF Code TestTests
//


import XCTest
import Combine
@testable import ANF_Code_Test

class ANFExploreCardTableViewControllerTests: XCTestCase {
  
  var testInstance: ANFExploreCardTableViewController!
  var subscribe: AnyCancellable?
  var expectation: XCTestExpectation?
  
  override func setUp() {
    testInstance = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as? ANFExploreCardTableViewController
    subscribe = testInstance.viewModel.$dataSource
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] _ in
        self?.expectation?.fulfill()
      })
  }
  
  func test_numberOfSections_ShouldBeOne() {
    let numberOfSections = testInstance.numberOfSections(in: testInstance.tableView)
    XCTAssert(numberOfSections == 1, "table view should have 1 section")
  }
  
  func test_numberOfRows_ShouldBeTen() {
    addExpectation {
      let numberOfRows = self.testInstance.tableView(self.testInstance.tableView, numberOfRowsInSection: 0)
      XCTAssert(numberOfRows == 10, "table view should have 10 cells")
    }
  }
  
  func test_cellForRowAtIndexPath_viewModel_shouldNotBeNil() {
    addExpectation {
      let firstCell = self.testInstance.tableView(self.testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ExploreCardTableViewCell
      XCTAssertNotNil(firstCell?.viewModel)
    }
  }
  
  func addExpectation(clouser: @escaping () -> Void) {
    // This is to trigger viewDidLoad()
    XCTAssertNotNil(testInstance.view)
    expectation = self.expectation(description: "Wait for export card call to succeed")
    waitForExpectations(timeout: 5) { error in
      XCTAssertNil(error)
      self.subscribe?.cancel()
      clouser()
    }
  }
}
