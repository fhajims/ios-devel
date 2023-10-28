//
//  ContentView.swift
//  omd_ios-devel_chapter_12-Sharing
//
//  Created by John on 05.01.21.
//

import SwiftUI
import MessageUI


// find system images: download SF symbols app, or take a look at:
//  https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/

struct ContentView: View{
    var body: some View {
            
        TabView {
            NavigationView{
                SharingView()
                    .navigationBarTitle(Text("Sharing"))
            }.tabItem({
                Image(systemName: "square.and.arrow.up")
                Text("Sharing")
              })
            NavigationView{
                MailSharingView()
                    .navigationBarTitle(Text("Mailing"))
            }.tabItem({
                Image(systemName: "envelope")
                Text("Mail")
              })
            NavigationView{
                PhotoSharingView()
                    .navigationBarTitle(Text("Share/Save Images"))
            }.tabItem({
                Image(systemName: "photo")
                Text("Photos")
              })
            NavigationView{
                SMSSharingView()
                    .navigationBarTitle(Text("Texting"))
            }.tabItem({
                Image(systemName: "text.bubble")
                Text("SMS")
              })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}








