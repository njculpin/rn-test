//
//  basicUITests.swift
//  basicUITests
//
//  Created by Nick Culpin on 6/22/20.
//  Copyright © 2020 basic. All rights reserved.
//

import XCTest

// selectable elements
private extension XCUIApplication {
    var searchBar: XCUIElement { self.otherElements["search-bar"] }
    var listTable: XCUIElement { self.tables["list-table"]}
}

class basicUITests: XCTestCase {
    
    override func setUp() {
        XCTAssertTrue(true)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearch() throws {
        let app = XCUIApplication()
        app.launch()
        // tap into the search bar
        app.searchBar.doubleTap()
        // todo: investigate why searchBar.type doesnt work
        // might be a non-storyboard accessibility issue?
        app.keys["J"].tap()
        app.keys["a"].tap()
        app.keys["c"].tap()
        app.keys["k"].tap()
        app.keys["space"].tap()
        app.buttons["shift"].tap()
        app.keys["J"].tap()
        app.keys["o"].tap()
        app.keys["h"].tap()
        app.keys["n"].tap()
        app.keys["s"].tap()
        app.keys["o"].tap()
        app.keys["n"].tap()
        app.buttons["search"].tap()
        
        // confirm table exists
        let table = app.listTable
        XCTAssertTrue(table.exists)
        
        // delay for data load / simulate pause in user response
        sleep(5)
        
        // check that the table has more than cell loaded
        XCTAssert(table.cells.count > 0, "Cell Count Less Than 1")
        
        // check for the 1st index
        let cell = app.listTable.cells.containing(.cell, identifier: "1")
        let nameLabel = cell.staticTexts["list-cell-label"].label
        XCTAssertEqual(nameLabel, "Better Together")
        
        // tap into detail
        cell.element.tap()
        
        // confirm detail view elements
        let detailNameLabel = app.staticTexts["detail-name-label"].label
        XCTAssertEqual(detailNameLabel, "Better Together")
        
        // close detail
        app.navigationBars.buttons.element(boundBy: 0).tap()

    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
