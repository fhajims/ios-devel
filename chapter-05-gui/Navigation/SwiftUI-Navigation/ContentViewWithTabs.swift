//
//  ContentView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Navigation
//
//  Created by john on 03.11.21.
//

import SwiftUI





struct ContentViewWithTabs: View {
    
    @Binding var showHiddenSpecialsViews:Bool
    
    @State private var currTab:Int = 1
    
    var body: some View {
        TabView(selection: $currTab) {
            Overview(currentTab: $currTab)
                .tabItem { Text("Overview") }.tag(1)
            OverlayBaseView()
                .tabItem { Text("Detail") }.tag(2)
            AlertsView()
                .tabItem { Text("Alerts") }.tag(3)
            OverlaySheetView()
                .tabItem { Text("Sheet") }.tag(4)
            NestedListView()
                .tabItem { Text("Stack") }.tag(5)
        }
        // Just for fun,
        // displaying a further "hidden" view 
        .onChange(of: currTab){ _, no in
            if no==6 {
                print("Selected number \(no)... so we open the (hidden) swipe demo")
                // see App.swift
                showHiddenSpecialsViews = true
            }
        }
    }
}

struct ContentViewWithTabs_Previews: PreviewProvider {
    @State
    static var showHidden = false
    
    static var previews: some View {
        ContentViewWithTabs(showHiddenSpecialsViews: $showHidden)
    }
}
