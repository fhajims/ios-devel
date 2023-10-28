//  ContentView.swift

import SwiftUI

struct ContentView: View {
    @State private var currTab = 2
    @State private var showFullscreen:Bool = false
    var body: some View {
        NavigationView{
            VStack{
                // manual trigger navigation to another view
                // replacing the current Navigation View:
                NavigationLink(
                    destination: PreviewAll(showFullscreen: $showFullscreen)) {
                        EmptyView()
                    }
                TabView(selection: $currTab) {
                    
                    Text("Manage Slides").tabItem {
                        Label("Manage", systemImage: "greetingcard")
                    }.tag(1)
                    
                    PreviewAll(showFullscreen: $showFullscreen).tabItem {
                        Label("Present", systemImage: "eye")
                    }.tag(2)
                }.navigationBarItems(trailing:
                                        
                                        Button(action: {
                    print("User wants to go to fullscreen...")
                    showFullscreen.toggle()
                }) {
                    Image(systemName: showFullscreen ?
                          "arrow.down.right.and.arrow.up.left" :
                            "arrow.up.left.and.arrow.down.right" ).imageScale(.large)
                }
                                     
                ).navigationBarHidden(currTab == 1)
            }
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
