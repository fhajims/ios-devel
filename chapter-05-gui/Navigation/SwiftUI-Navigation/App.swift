//
//  omd_ios_devel_chapter_05_SwiftUI_NavigationApp.swift
//  omd-ios-devel-chapter-05-SwiftUI-Navigation
//
//  Created by john on 03.11.21.
//

import SwiftUI

@main
struct omd_ios_devel_chapter_05_SwiftUI_NavigationApp: App {
    @State var showHiddenSpecialsViews = false
    
    var body: some Scene {
        WindowGroup {
            if showHiddenSpecialsViews{
                TheHiddenEasterEggView(showHiddenSpecialsViews: $showHiddenSpecialsViews)
            }else{
                ContentViewWithTabs(showHiddenSpecialsViews: $showHiddenSpecialsViews)
            }
        }
    }
}
