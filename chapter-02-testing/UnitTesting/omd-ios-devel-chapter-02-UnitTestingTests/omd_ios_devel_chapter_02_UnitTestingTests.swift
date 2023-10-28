//
//  omd_ios_devel_chapter_02_UnitTestingTests.swift
//  omd-ios-devel-chapter-02-UnitTestingTests
//
//  Created by John on 31.01.23.
//

import XCTest
@testable import omd_ios_devel_chapter_02_UnitTesting

final class UnitTestsForLoginService: XCTestCase {
        func testIncrement() {
            var loginService = LoginService()
            loginService.increment()
            XCTAssertEqual(loginService.loginAttempts, 1)
        }
        
        func testDecrement() {
            var loginService = LoginService()
            loginService.decrement()
            XCTAssertEqual(loginService.loginAttempts, -1)
        }
}
