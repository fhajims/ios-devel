//
//  omd_ios_devel_chapter_04_Data_ModellingTests.swift
//  omd-ios-devel-chapter-04-Data-ModellingTests
//
//  Created by John on 06.03.23.
//

import XCTest
@testable import omd_ios_devel_chapter_04_Data_Modelling

final class omd_ios_devel_chapter_04_Data_ModellingTests: XCTestCase {
/*
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    */
    func testSlideCreation() throws {
        let sunsetSlide = Slide(title: "Sunset",
                      imgFileName: "sunset.png")
        print("The first slide \(sunsetSlide)")
        XCTAssert(sunsetSlide.title == "Sunset")
        
    }

    func testSlideManager() throws {
        let mgmt = SlideManager(withInitialData: true)
        print("Some slides: \(mgmt.slides)")
        XCTAssert(mgmt.slides.last?.title == "At the beach")
    }
    
    
}
