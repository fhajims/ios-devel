//
//  omd_ios_devel_chapter_02_UITestingUITests.swift
//  omd-ios-devel-chapter-02-UITestingUITests
//
//  Created by John on 31.01.23.
//

import XCTest

final class omd_ios_devel_chapter_02_UITestingUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testForTitleToExists() throws {
        
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let selectedValTitle = app.staticTexts["theTitle"]
        XCTAssertTrue(selectedValTitle.waitForExistence(timeout: 5))

    }
    
    func testSlidingToGivenPosition() throws {

        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // for finding a view
        // the accessibility id must be set:
        let slider = app.sliders["favNumberSlider"]

        // automate the interaction
        
        // slider.swipeRight()
        slider.adjust(toNormalizedSliderPosition: 0.8)
        
        // Check the result (location/setting) of slider:
        if let selectedVal = slider.value as? String{
            
            // Will fail with msg: XCTAssertEqual failed: ("8") is not equal to ("9")
            // XCTAssertEqual(selectedVal, "9")
            
            // Should succeed:
            XCTAssertEqual(selectedVal, "8")
        }
    }

}
