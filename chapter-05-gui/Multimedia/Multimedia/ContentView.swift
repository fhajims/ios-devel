//
//  ContentView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Multimedia
//
//  Created by John on 22.10.23.
//

import SwiftUI
import SwiftUI

struct ContentView: View {
    @State private var currTab=1
    var body: some View {
        TabView(selection: $currTab) {
            PlayAudioView().tabItem { Text("Audio") }.tag(1)
            PlayVideoView().tabItem { Text("Video") }.tag(2)
        }
    }
}

#Preview {
    ContentView()
}
