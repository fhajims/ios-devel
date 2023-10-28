//  ContentView.swift

import SwiftUI

struct ContentView: View {
    
    @State private var currTab = 2
    
    var body: some View {
        TabView(selection: $currTab) {
            
            Text("Manage Slides").tabItem {
                Label("Manage", systemImage: "greetingcard")
            }.tag(1)
            
            PreviewAll().tabItem {
                Label("Present", systemImage: "eye")
            }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let previewSlideMgr = SlideManager( withInitialData: true)
    
    static var previews: some View {
        ContentView()
            .environmentObject(previewSlideMgr)
        ContentView()
            .environmentObject(previewSlideMgr)
            .preferredColorScheme(.dark)
    }
}
