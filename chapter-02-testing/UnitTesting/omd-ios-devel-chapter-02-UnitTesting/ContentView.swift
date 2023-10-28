//
//  ContentView.swift
//  omd-ios-devel-chapter-02-UnitTesting
//
//  Created by John on 31.01.23.
//

import SwiftUI

struct ContentView: View {
    
    @State
    var selection = 1
    var body: some View {
        TabView(selection: $selection) {
            LoginFormView().tabItem {
                Text("Login") }.tag(1)
            Text("Registratio").tabItem {
                Text("Register") }.tag(2)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
