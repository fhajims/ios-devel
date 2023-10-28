//
//  omd_ios_devel_chapter_05_UnitTestingTests.swift
//  omd-ios-devel-chapter-05-UnitTestingTests
//
//  Created by John on 03.12.21.
//

import XCTest

// module name (possibly replace - with _ )
// The module name should be the same on Target->Build Settings-> Product Module Name
// Check this, by filtering for "product module name" in the "build settings" view of the main app target (here: omd-ios-devel-chapter-05-UnitTesting)
@testable import UTesting

class omd_ios_devel_chapter_05_UnitTestingTests: XCTestCase {
    var slidMgmt: SlideManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        slidMgmt = SlideManager.sharedInstance
        slidMgmt.clear()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        slidMgmt.clear()
    }
    
    func testAddingASlideWithEmptyTitle() throws {
        XCTAssertNil(slidMgmt.lastSlideAdded)
        
        let sunsetSlide = Slide(id: 7, title: "")
        slidMgmt.add(sunsetSlide)
        if let lsa = slidMgmt.lastSlideAdded {
            XCTAssertEqual(lsa, sunsetSlide)
        }else{
            XCTAssertThrowsError("We expect (after a slide added) some slide to be returned")
        }
    }
    func testAddingSlideWithIdAndTitle() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNil(slidMgmt.lastSlideAdded)
        
        let sunsetSlide = Slide(id: 7, title: "Sunset")
        slidMgmt.add(sunsetSlide)
        if let lsa = slidMgmt.lastSlideAdded {
            // This will fail, because the title of the slide differs
            // Error:
            // testAddingSlideWithIdAndTitle(): XCTAssertEqual failed: ("Slide(id: 7, title: "Sunset!")") is not equal to ("Slide(id: 7, title: "Sunset")")
            XCTAssertEqual(lsa, sunsetSlide)
        }else{
            XCTAssertThrowsError("We expect (after a slide added) some slide to be returned")
        }
    }
    
    func testPerformanceExample() throws {
        // Note: possibly you are warned about no baseline set for time
        //       Click "Show" (on the gray hint below)
        //       to open the pop-up and add/update the time of your baseline!
        //
        //       Technical hint: you will find the recorded times/baselines
        //       in subfolder *.xcodeproj/xcshareddata/xcbaselines/
        
        // We measure the performance of adding many slides.
        self.measure {
            // Put the code you want to measure the time of here.
            //for  i in 1...10_000 {
            for  i in 1...876{ // change the count and see changes to the baseline ;)
                let sunsetSlide = Slide(id: i, title: "Sunset-\(i)")
                slidMgmt.add(sunsetSlide)
            }
        }
    }
    
}
