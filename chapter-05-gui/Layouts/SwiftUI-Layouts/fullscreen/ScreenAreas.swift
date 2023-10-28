//
//  ScreenAreas.swift
//  omd-ios-devel-chapter-05-SwiftUI-Layouts
//
//  Created by John on 19.01.22.
//

import SwiftUI

struct ScreenAreas: View {
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Text("Sceen Layout").font(.largeTitle)
                Text("FullScreen, Status, and Tab Bars").multilineTextAlignment(.center)
                Spacer()
                GroupBox(label:
                            Label("Layout", systemImage: "display")
                ) {
                    HStack{
                        Text("Save Area")
                        NavigationLink(destination:FullScreenWithSafeArea() ){
                            Text("Present in fullscreen")
                                .padding()
                        }
                    }
                    
                }
                Spacer()
            }
        }
    }
}

struct ScreenAreas_Previews: PreviewProvider {
    static var previews: some View {
        ScreenAreas()
        ScreenAreas().preferredColorScheme(.dark)
    }
}
