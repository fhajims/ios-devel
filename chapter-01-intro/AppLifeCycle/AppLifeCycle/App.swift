//
//  omd_ios_devel_chapter_01_AppLifeCycleApp.swift
//  omd-ios-devel-chapter-01-AppLifeCycle
//
//  Created by John on 28.12.21.
//

import SwiftUI

@main
struct omd_ios_devel_chapter_01_AppLifeCycleApp: App {
    
    // Note on the Scene's state:
    //   tracked in the environment
    // property 'scenePhase' is available in the environment
    @Environment(\.scenePhase) var currentScenePhase
    // https://developer.apple.com/documentation/swiftui/scenephase

    // Optionally, we might initialise our app
    // (similar to didFinishLaunchWithOptions method of an AppDelegate)
    init(){
        print("Initialising the App.")
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.onChange(of: currentScenePhase) { _ , weAreinPhase in
            print("\(Date()): The scene phase has changed to '\(weAreinPhase)'.")
            switch weAreinPhase {
            case .active:
                print(" Hurray, active (again): active")
            case .inactive:
                print(" OK, time for a break: inactive")
            case .background:
                print(" Background")
            @unknown default:
                print(" No idea which aditional phase we could be in?")
            }
            
        }
    }
}


