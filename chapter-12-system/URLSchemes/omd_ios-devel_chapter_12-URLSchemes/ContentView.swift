//
//  ContentView.swift
//  omd_ios-devel_chapter_12-URLSchemes
//
//  Created by John on 05.01.21.
//

import SwiftUI

// to opent our app via url (scheme):
//    e.g: "swiftuislideshow://whatever"
// Find details at: https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app 
// (1) add URLTypes to Info.plist and specify "swiftuislideshow"
/*
 <key>CFBundleURLTypes</key>
 <array>
 <dict>
 <key>CFBundleURLSchemes</key>
 <array>
 <string>swiftuislideshow</string>
 </array>
 </dict>
 </array>
 */



// to open Settings
func openTheSettings(){
    print("Open settings")
    guard let url = URL(string: UIApplication.openSettingsURLString) else {
        return
    }
    UIApplication.shared.open(url)
}


struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("URL Schemes")
                    .fontWeight(.heavy)
                    .padding()
                Text("A new custom protocol 'swiftuislideshow' is registered. Now go to Safari browser and open url 'swiftuislideshow://summer/?2030#3'.").multilineTextAlignment(.center)
                    .padding(.horizontal)
                NavigationLink(destination: HowToView()) {
                    Text("HowTo").padding()
                }
                Spacer()
                NavigationLink(destination: TwoWaysToOpenUrlsView() ) {
                    Text("Open URLs").padding()
                }
                Button("Open App-Settings") {
                    openTheSettings()
                }.padding(.bottom)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
