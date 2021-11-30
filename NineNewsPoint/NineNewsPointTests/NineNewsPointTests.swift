//
//  NineNewsPointTests.swift
//  NineNewsPointTests
//
//  Created by Animesh Mishra on 26/11/21.
//

import XCTest
import NineNewsPointServices

@testable import NineNewsPoint

class NineNewsPointViewModelTests: XCTestCase {
    // MARK: Constants
    static let mockJsonFileName = "GetNewsPointData"

    // MARK: Variables
    var nineNewsPointViewModel:NineNewsPointViewModel? = NineNewsPointViewModel()
    var newsPointData: NineNewsPointData!
        
    override func setUpWithError() throws {
        super.setUp()
        newsPointData = try getData(fromJSON: NineNewsPointViewModelTests.mockJsonFileName)
    }

    override func tearDownWithError() throws {
        newsPointData = nil
    }

    /// - Experiment:test CellForItemAtIndexPathForSection method success sceanrio
    /// - Note: Expected Result :  NineNewsPointDataSource dataSource should not be nil
    func testCellForItemAtIndexPathForSection() {
        nineNewsPointViewModel?.assets = newsPointData.assets
        let dataSource = nineNewsPointViewModel?.cellForItemAtIndexPathForSection(row: 1)
        XCTAssertNotNil(dataSource)
    }
    
    /// - Experiment:test CellForItemAtIndexPathForSection method failure sceanrio
    /// - Note: Expected Result :  NineNewsPointDataSource dataSource should be nil and handle without crash
    func testCellForItemAtIndexPathForSectionFail() {
        let dataSource = nineNewsPointViewModel?.cellForItemAtIndexPathForSection(row: -1)
        XCTAssertNil(dataSource)
    }
    
    /// - Experiment:test RequestAPI
    /// - Note: Expected Result :  NineNewsPointViewModel's assests property should have value.
    /// - Note: Response wait time should be 5 seconds.
    func testRequestAPI() {
        let expectation = self.expectation(description: "RequestAPI is working fine")
        XCTAssertNil(nineNewsPointViewModel?.assets)
        nineNewsPointViewModel?.requestData()
        let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(nineNewsPointViewModel?.assets)
            expectation.fulfill()
        } else {
            XCTFail("Delay interrupted")
        }
    }

}

