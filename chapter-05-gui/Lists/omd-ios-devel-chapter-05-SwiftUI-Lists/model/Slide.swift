//
//  Slide.swift
//  omd-ios-devel-chapter-05-SwiftUI-Lists
//
//  Created by john on 03.11.21.
//

import Foundation


struct Slide :Identifiable, Hashable {
    enum Kind:String, CaseIterable, Identifiable {
        // Identifiable enums for a list (here: sections / section headers)
        var id: Self { self }
        
        case water = "Water"
        case sun = "Sun"
        case other = "Other"
    }
    var id = UUID()
    var title:String
    var imageName:String?=nil
    var kindOfSlide = Kind.other
    
    var icon:String {
        switch self.kindOfSlide {
        case .sun: return "sunrise"
        case .water: return "water.waves"
        default: return "photo.circle"
        }
    }
}
