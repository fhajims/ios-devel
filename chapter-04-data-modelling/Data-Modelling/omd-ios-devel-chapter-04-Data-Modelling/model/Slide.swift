//
//  Slide.swift
//  omd-ios-devel-chapter-04-Data-Modelling
//
//  Created by John on 06.03.23.
//

import Foundation

struct Slide:Equatable, Identifiable{
    let id:UUID = UUID()
    var title:String
    var imgFileName:String? = nil
}
