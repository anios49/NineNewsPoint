//
//  XCTestCases+JSON.swift
//  NineNewsPointTests
//
//  Created by Animesh Mishra on 29/11/21.
//
//
import XCTest

extension XCTestCase {
    enum TestError: Error {
        case fileNotFound
    }
    
    /// Get  a top-level value of the given type from the given local JSON file
    /// - Parameter fileName: Local File Name
    /// - Throws: flag up errors
    /// - Returns: Data in model representation
    func getData<T: Decodable>(fromJSON fileName: String) throws -> T {
        do {
            let localFilePath = Bundle.main.path(forResource: fileName, ofType: "json")
            let jsonString = try NSString(contentsOfFile: localFilePath!, encoding: String.Encoding.utf8.rawValue)
            let jsonData = jsonString.data(using: String.Encoding.utf8.rawValue)!
            let decoder = JSONDecoder()
            let decodedData = try! decoder.decode(T.self, from: jsonData)
            return decodedData
        } catch {
            XCTFail("Missing File: \(fileName).json")
            throw TestError.fileNotFound
        }
    }
}
