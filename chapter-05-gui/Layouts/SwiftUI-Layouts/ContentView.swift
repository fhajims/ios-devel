//
//  ContentView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Layouts
//
//  Created by John on 19.01.22.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 2
    var body: some View {
        TabView(selection: $selectedTab) {
            
            Text("Align Views, Spacer, Sizes, Scrolling")
                .tabItem { Text("Align") }.tag(1)
            
            // FullScreen, Status, and Tab Bars
            ScreenAreas()
                .tabItem { Text("FullScreen") }.tag(2)
            
            Text("Stack and group vertical (v), horizontal(h), layerd (z)")
                .tabItem { Text("Group") }.tag(2)
            
            Text("Lists and Grids")
                .tabItem { Text("Grids") }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().preferredColorScheme(.dark)
    }
}
