//
//  omd_ios_devel_chapter_05_SwiftUI_DataBindingApp.swift
//  omd-ios-devel-chapter-05-SwiftUI-DataBinding
//
//  Created by John on 19.01.22.
//

import SwiftUI

@main
struct omd_ios_devel_chapter_05_SwiftUI_DataBindingApp: App {
    var body: some Scene {
        
        // create Slide management for app without demo data
        let slideMgmt = ObservableSlideModel( withInitialData: false)
        
        WindowGroup {
            ContentView().environmentObject(slideMgmt)
        }
    }
}
