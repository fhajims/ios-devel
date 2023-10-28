//
//  Slide.swift
//  omd-ios-devel-chapter-05-UnitTesting
//
//  Created by John on 03.12.21.
//

import Foundation

// Identifiable is required for "List" handling (remove, find, update)
struct Slide:Equatable, Identifiable {
    let id:Int
    var title: String
}
