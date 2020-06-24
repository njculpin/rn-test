//
//  basicTests.swift
//  basicTests
//
//  Created by Nick Culpin on 6/22/20.
//  Copyright © 2020 basic. All rights reserved.
//

import XCTest
@testable import basic

class basicTests: XCTestCase {
    
    var session: URLSession!

    override func setUpWithError() throws {
        session = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        session = nil
    }
    
      func testITunes() {
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")

        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?

        let dataTask = session.dataTask(with: url!) { data, response, error in
          statusCode = (response as? HTTPURLResponse)?.statusCode
          responseError = error
          promise.fulfill()
        }
        dataTask.resume()

        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
      }


    func testAPISearch() throws {
        let api = API()
        api.download(searchTerm: "Jack Johnson") { results, errorMessage in
            XCTAssert(errorMessage != "", errorMessage)
            XCTAssert(results!.count <= 0, "API Download No Results")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
