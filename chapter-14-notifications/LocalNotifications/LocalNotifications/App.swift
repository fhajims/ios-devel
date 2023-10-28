//
//  omd_ios_devel_chapter_14_RemoteNotificationsApp.swift
//  omd-ios-devel-chapter-14-RemoteNotifications
//
//  Created by John on 30.01.23.
//

import SwiftUI

// Callback when notification is tapped:
class AnotherLocalNotifCenter: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("User tapped on the notification: \(response)")

        // handle response an any way
        Task {
            print("We try to (async) reset the badge (small red icon  with number) to 0")
            try? await center.setBadgeCount(0)
        }
        completionHandler()
    }
}



@main
struct omd_ios_devel_chapter_14_RemoteNotificationsApp: App {
    // Register the "tapped on notification" - callback (on app initialisation)
    private var notificDelegate : UNUserNotificationCenterDelegate = AnotherLocalNotifCenter()
    init(){
        UNUserNotificationCenter.current().delegate = notificDelegate
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
