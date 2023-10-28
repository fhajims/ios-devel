// SlideShowAppApp.swift

import SwiftUI

@main
struct omd_ios_devel_chapter_01_SwiftUI_SlideShowAppApp: App {

    let slideMgr = SlideManager( withInitialData: true)
        
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(slideMgr)
        }
    }
}
