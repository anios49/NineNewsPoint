//
//  NineNewsPointUITests.swift
//  NineNewsPointUITests
//
//  Created by Animesh Mishra on 26/11/21.
//

import XCTest

class NineNewsPointUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// - Experiment:Test the user flow to open app and then tap on news to load on WKWebView. Then return back to home page.
    /// - Note: Expected Result :  User journey should be complete without interuption
    func testUserflowToOpenNews() {
        let app = XCUIApplication()
        let firstCell = XCUIApplication().collectionViews.cells.firstMatch
        XCUIDevice.shared.orientation = .portrait
        let newsListButton = app.navigationBars["News Details"].buttons["News List"]
        app.launch()
        
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: -10))
        start.press(forDuration: 0, thenDragTo: finish)

        finish.press(forDuration: 0, thenDragTo: start)
        let exp = expectation(description: "Userflow should work properly within time")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        firstCell.tap()
                
        newsListButton.tap()

        if result == XCTWaiter.Result.timedOut {
            exp.fulfill()
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    /// - Experiment:Test Collection View Items
    /// - Note: Expected Result :  should be able to open all the present tile on screen
    func testCollectionViewItems() throws {
        let app = XCUIApplication()
        let collectionViewsCells = app.collectionViews.cells
        XCUIDevice.shared.orientation = .portrait
        let newsListButton = app.navigationBars["News Details"].buttons["News List"]
        
        app.launch()

        if collectionViewsCells.count > 0 {

            let exp = expectation(description: "Wait for collection view cells")

            for i in stride(from: 0, to: collectionViewsCells.count , by: 1) {
                // Grab the first cell and verify that it exists and tap it
                let collectionViewsCell = collectionViewsCells.element(boundBy: i)
                XCTAssertTrue(collectionViewsCell.exists, "The \(i) cell is in place on the Collection View")
                collectionViewsCell.tap()
                newsListButton.tap()
                
                if i == (collectionViewsCells.count - 1) {
                    exp.fulfill()
                }
            }
            waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(true, "Finished validating the collection view cells")

        } else {
            XCTAssert(false, "Was not able to find any collection view cells")
        }
    }
    
    /// - Experiment:Test WKWebView
    /// - Note: Expected Result :  share data should work fine
    func testWKWebView() throws {
        let app = XCUIApplication()
        let firstCell = XCUIApplication().collectionViews.cells.firstMatch
        XCUIDevice.shared.orientation = .portrait
        let newsListButton = app.navigationBars["News Details"].buttons["News List"]
        app.launch()

        let exp = expectation(description: "WKWebView should work properly within time")
        firstCell.tap()
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        newsListButton.tap()

        if result == XCTWaiter.Result.timedOut {
            exp.fulfill()
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    /// - Experiment:test Share Button
    /// - Note: Expected Result :  share data should work fine
    func testShareButton() {
        let app = XCUIApplication()
        app.launch()
        XCUIDevice.shared.orientation = .portrait
        let firstCell = XCUIApplication().collectionViews.cells.firstMatch
        
        let exp = expectation(description: "Sharing News should work properly")
        firstCell.buttons["Share"].tap()
        app.collectionViews.cells["Messages"].children(matching: .other).element.tap()
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)

        if result == XCTWaiter.Result.timedOut {
            exp.fulfill()
        } else {
            XCTFail("Delay interrupted")
        }

    }
    
    /// - Experiment:test Pull to refresh and device Orientation
    /// - Note: Expected Result :  Pull to refresh should work fine
    /// - Note: Expexted Result : Application should support landscape
    func testPullToRefreshAndDeviceOrientation() {
        let app = XCUIApplication()
        app.launch()
        let firstCell = XCUIApplication().collectionViews.cells.firstMatch
        
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
        start.press(forDuration: 0, thenDragTo: finish)
        
        XCUIDevice.shared.orientation = .landscapeLeft
        
        XCTAssert(XCUIDevice.shared.orientation == .landscapeLeft)
    }

}
