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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
