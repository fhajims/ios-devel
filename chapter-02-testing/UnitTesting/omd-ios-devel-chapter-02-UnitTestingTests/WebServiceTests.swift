//
//  WebServiceTests.swift
//  omd-ios-devel-chapter-02-UnitTestingTests
//
//  Created by John on 31.01.23.
//

import XCTest

@testable import omd_ios_devel_chapter_02_UnitTesting

final class WebServiceTests: XCTestCase {
    func testFetchData() async throws {
        let srvClient = WebServiceClient()
        // let expectation = self.expectation(description: "Fetching data")
        
            let data = try? await srvClient.fetchData(heroID: 1)
            XCTAssertNotNil(data) // 1: Ant-Man
            if let data=data {
                XCTAssertEqual(data,"Ant-Man")
            }        
    }
}
