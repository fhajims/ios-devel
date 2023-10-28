//
//  CheckLoginForm.swift
//  omd-ios-devel-chapter-02-UnitTestingTests
//
//  Created by John on 31.01.23.
//

import XCTest


import SwiftUI

// convention for import of modules with names including dashes (-):
// convert dashes (-) to underscore (_)
//               omd-ios-devel-chapter-02-UnitTesting
@testable import omd_ios_devel_chapter_02_UnitTesting

final class CheckLoginForm: XCTestCase {

    func testFormWithEmailAndPassword() {
        let hostingController = UIHostingController(rootView: LoginFormView())
        
        // accessing variables
        // hostingController.rootView.email
        
        
        hostingController.view.layoutIfNeeded()

        // TODO: check why no subviews available??
        // set breakpoint and try
        // (lldb) po hostingController.view.subviews
        //        0 elements
        
        let emailField = hostingController.view.subviews.first { $0 is UITextField } as? UITextField
        
        
        //debugPrint(emailField)
        XCTAssertNotNil(emailField)
        XCTAssertEqual(emailField?.placeholder, "Email")
        XCTAssertEqual(emailField?.text, "mia.kia@lia.com")

        let passwordField = hostingController.view.subviews.first { $0 is UITextField } as? UITextField
        XCTAssertNotNil(passwordField)
        XCTAssertEqual(passwordField?.placeholder, "Password")
        XCTAssertEqual(passwordField?.text, "veryverysecure!")
    }

}
