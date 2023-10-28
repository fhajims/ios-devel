//
//  omd_ios_devel_chapter_10_SensorsApp.swift
//  omd-ios-devel-chapter-10-Sensors
//
//  Created by John on 21.12.22.
//

import SwiftUI

@main
struct omd_ios_devel_chapter_10_SensorsApp: App {
    
    let baroService = BaroService()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(baroService)
        }
    }
}
