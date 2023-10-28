//
//  ContentView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Lists
//
//  Created by john on 03.11.21.
//

import SwiftUI


struct ContentView: View {
    
    @AppStorage("RememberTheTabToStartWith", store: .standard)
    private var current_tab = 1
    
    var body: some View {
        
        TabView(selection: $current_tab) {
            ListWithFilterView().tabItem {
                Text("Filter")
                
            }.tag(1)
            ListAndEditView().tabItem {
                Text("Edit")
                
            }.tag(2)
            ListInSectionsView().tabItem {
                Text("Sections")
            }.tag(3)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SlideshowManagement.shared)
            .environment(\.slideShowConfigShowIcons, false)
        ContentView()
            .environmentObject(SlideshowManagement.shared)
            .environment(\.slideShowConfigShowIcons, true)
            .preferredColorScheme(.dark)
    }
}
