//
//  ContentView.swift
//  omd-ios-devel-chapter-09-Animation
//
//  Created by john on 13.01.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = 1
    var body: some View {
        
        TabView(selection: $selection) {
            AnimateOnTapView().tabItem { Text("Resize") }.tag(1)
            ShakeNotOKView().tabItem { Text("Shaky") }.tag(2)
            CustomDrawingView().tabItem {Text("Custom") }.tag(3)
        }
    }
}

#Preview{
    ContentView()
}
