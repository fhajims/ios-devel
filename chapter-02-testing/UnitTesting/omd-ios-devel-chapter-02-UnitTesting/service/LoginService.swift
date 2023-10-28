//
//  LoginService.swift
//  omd-ios-devel-chapter-02-UnitTesting
//
//  Created by John on 31.01.23.
//

import Foundation

struct LoginService {
    var loginAttempts = 0
    
    mutating func increment() {
        loginAttempts += 1
    }
    
    mutating func decrement() {
        loginAttempts -= 1
    }
}
