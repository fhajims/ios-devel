//
//  ContentView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Tabs
//
//  Created by john on 03.11.21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
            Text("Scan QR")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("ScanQR")
                        Text("QR")
                    }
                }
                .tag(0)
            Text("Enter Code")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("EnterCode")
                        Text("Form")
                    }
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
