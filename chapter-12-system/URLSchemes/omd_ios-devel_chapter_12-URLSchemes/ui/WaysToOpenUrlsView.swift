//
//  TwoWaysToOpenUrlsView.swift
//  omd_ios-devel_chapter_12-URLSchemes
//
//  Created by John on 29.12.21.
//

import SwiftUI




struct TwoWaysToOpenUrlsView: View {
    @State private var selection:Int = 1
    var body: some View {
        TabView(selection: $selection) {
            WayOneView().tabItem { Text("Show me way one)") }.tag(1)
            WayTwoView().tabItem { Text("Show me way two") }.tag(2)
        }
        .padding(.horizontal)
        .frame(height: 170.0)
    }
}

struct TwoWaysToOpenUrlsView_Previews: PreviewProvider {
    static var previews: some View {
        TwoWaysToOpenUrlsView()
    }
}
