//
//  SafeAreaViews.swift
//  omd-ios-devel-chapter-05-SwiftUI-Widgets
//
//  Created by john on 17.01.22.
//

import SwiftUI

struct FullScreenWithSafeArea: View {
    var body: some View {
        ZStack{
            LinearGradient(
                colors: [.yellow, .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
            VStack{Text("We ignore the safe area!")
                Text("So we use the navigation bar, tool bar, tab bar and other spaces.").font(.footnote).multilineTextAlignment(.center).padding(.top)
            }
        }.ignoresSafeArea(
            .container, // .keyboard
            edges: [.bottom] // region .top, .leading,...
        )
            .navigationTitle("Non-safe area")
            // We might add our own "safe area"
            // here on the top (with some space to the main view):
            .safeAreaInset(
                edge: .top,
                alignment: .center,
                spacing: 7) {
                 // we put another view into the original safe area
                 Color.clear
                 .frame(height: 15)
                 .background(.blue)//Material.bar)
                }
    }
}

struct SafeAreaViews_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenWithSafeArea()
        FullScreenWithSafeArea().preferredColorScheme(.dark)
    }
}
