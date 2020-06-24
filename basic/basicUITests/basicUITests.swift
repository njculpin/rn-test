//
//  basicUITests.swift
//  basicUITests
//
//  Created by Nick Culpin on 6/22/20.
//  Copyright © 2020 basic. All rights reserved.
//

import XCTest

class basicUITests: XCTestCase {
    
    func testSearchTest() throws {
        let app = XCUIApplication()
        app.launch()
        app.otherElements["searchBar"].tap()
        sleep(5)
        app.otherElements["searchBar"].typeText("search text")
        print(app.debugDescription)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
