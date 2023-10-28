//
//  ContentView.swift
//  omd-ios-devel-chapter-14-RemoteNotifications
//
//  Created by John on 30.01.23.
//

import SwiftUI

struct ContentView: View {
    
    @State var tab=1
    var body: some View {
        TabView(selection: $tab) {
            SendNotificationView().tabItem {
                Text("Send")
            }.tag(1)
            ListNotificationView(
                alreadyDeliveredNotifications: [],
                currentlyScheduledNotifications: [])
            .tabItem {
                Text("List")
            }.tag(2)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
