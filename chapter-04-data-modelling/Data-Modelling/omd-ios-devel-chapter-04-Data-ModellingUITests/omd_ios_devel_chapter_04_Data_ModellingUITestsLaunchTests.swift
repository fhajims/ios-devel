//
//  omd_ios_devel_chapter_04_Data_ModellingUITestsLaunchTests.swift
//  omd-ios-devel-chapter-04-Data-ModellingUITests
//
//  Created by John on 06.03.23.
//

import XCTest

final class omd_ios_devel_chapter_04_Data_ModellingUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
