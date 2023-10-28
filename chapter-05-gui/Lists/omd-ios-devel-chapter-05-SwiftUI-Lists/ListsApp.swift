//
//  omd_ios_devel_chapter_05_SwiftUI_ListsApp.swift
//  omd-ios-devel-chapter-05-SwiftUI-Lists
//
//  Created by john on 03.11.21.
//

import SwiftUI


private struct SlideShowConfig: EnvironmentKey {
    static let defaultValue:Bool = true
}
extension EnvironmentValues {
    var slideShowConfigShowIcons: Bool {
        get { self[SlideShowConfig.self] }
        set { self[SlideShowConfig.self] = newValue }
    }
}
 
@main
struct SlideshowApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SlideshowManagement.shared)
                .environment(\.slideShowConfigShowIcons, true)
        }
    }
}
