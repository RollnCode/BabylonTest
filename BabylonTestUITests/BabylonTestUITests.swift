//
//  BabylonTestUITests.swift
//  BabylonTestUITests
//
//  Created by Vitalii Yevtushenko on 6/18/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import XCTest

class BabylonTestUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testBaseNavigations() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["eum et est occaecati"]/*[[".cells.staticTexts[\"eum et est occaecati\"]",".staticTexts[\"eum et est occaecati\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let postsButton = app.navigationBars["Post Detail"].buttons["Posts"]
        postsButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["magnam facilis autem"]/*[[".cells.staticTexts[\"magnam facilis autem\"]",".staticTexts[\"magnam facilis autem\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["dolorem dolore est ipsam"]/*[[".cells.staticTexts[\"dolorem dolore est ipsam\"]",".staticTexts[\"dolorem dolore est ipsam\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        postsButton.tap()
        
    }

}
