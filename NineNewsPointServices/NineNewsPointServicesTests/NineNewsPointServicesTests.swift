//
//  NineNewsPointServicesTests.swift
//  NineNewsPointServicesTests
//
//  Created by Animesh Mishra on 26/11/21.
//

import XCTest
@testable import NineNewsPointServices

class NineNewsPointServicesTests: XCTestCase {
    static let imageURL = "https://www.fairfaxstatic.com.au/content/dam/images/h/2/0/1/g/t/image.related.articleLeadwide.1500x844.p59c9i.13zzqx.png/1638153174431.jpg"
    
    /// Unit Test for getNineNewsDataAPI
    /// - Experiment:Testing URL to get the response
    /// - Note: Expected Result : data should not be nil
    /// - Note: Response wait time should be 5 seconds.
    func testGetNineNewsData() {
        // Put the code you want to measure the time of here.
        setUp()
        let expectation = self.expectation(description: "Get NineNewsData service is received successfully")
        Networking.fetchNineNewsData { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                expectation.fulfill()
            default:
                XCTFail("Expected get NineNewsData service response with error json")
            }
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
    /// Unit Test for getNineNewsDataAPI
    /// - Experiment:Testing failure scenarios
    /// - Note: Expected Result : data should be nil
    /// - Note: Response wait time should be 5 seconds.
    func testGetNineNewsDataError() {
        let expectation = self.expectation(description: "Get NineNewsData is not working")
        Networking.fetchNineNewsData(shouldFail: true) { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            default:
                XCTFail("Expected get NineNewsData service response with error json")
            }
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
    /// Unit Test for Request Image Data
    /// - Experiment:Testing Image from Server
    /// - Note: Expected Result : data should not be nil (Please check the NineNewsPointServicesTests.imageURL on browser, if test get failed)
    /// - Note: Response wait time should be 5 seconds.
    func testRequestImageData() {
        let expectation = self.expectation(description: "Get RequestImageData is working fine")
        guard let url = URL(string: NineNewsPointServicesTests.imageURL) else { return }
        
        networking.requestImageData(url: url) {(result) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                expectation.fulfill()
            default:
                XCTFail("Expected get RequestImageData response with error json")
            }
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
    /// Unit Test for Load Image (extension)
    /// - Experiment:loading Image from Server
    /// - Note: Expected Result : image should have value in pngData (Please check the NineNewsPointServicesTests.imageURL on browser, if test get failed)
    /// - Note: Response wait time should be 5 seconds.
    func testLoadImage() {
        let expectation = self.expectation(description: "LoadImage is working fine with Valid URL")
        let imageView = UIImageView()
        imageView.loadImage(urlSting: NineNewsPointServicesTests.imageURL)
        let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(imageView.image?.pngData())
            expectation.fulfill()
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    /// Unit Test for Load Image (extension)
    /// - Experiment:loading Image from Server Error
    /// - Note: Expected Result : image pngData value will be nil (Please check the NineNewsPointServicesTests.imageURL on browser, if test get failed)
    /// - Note: Response wait time should be 5 seconds.
    func testLoadImageError() {
        let expectation = self.expectation(description: "LoadImage is not working fine with Invalid URL")
        let imageView = UIImageView()
        imageView.loadImage(urlSting:"")
        let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNil(imageView.image?.pngData())
            expectation.fulfill()
        } else {
            XCTFail("Delay interrupted")
        }
    }
}
