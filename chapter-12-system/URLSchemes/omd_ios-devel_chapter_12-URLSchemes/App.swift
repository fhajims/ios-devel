//
//  omd_ios_devel_chapter_12_URLSchemesApp.swift
//  omd_ios-devel_chapter_12-URLSchemes
//
//  Created by John on 05.01.21.
//

import SwiftUI

// In Info.plist "swiftuislideshow" is registered as scheme for this app
// In this example, the URL is "swiftuislideshow://summer/?2030#3".
//  So we get for the components:
//    scheme = summer
//    user
//    password
//    host= summer
//    port
//    path= /
//    query= 2030
//    fragment=3
func handleURLatAppStart(_ url: URL){
    // slides://summer/beach/id/13?lang=en&k=5#5
    print("DEBUG: url = '\(url)'.")         // 'slides://summer/beach/id/13.xml?lang=en#5'.
    print("DEBUG: open slide \(url.path)'") // '/summer/beach/id/13'.
    if let components = NSURLComponents(
        url: url,
        resolvingAgainstBaseURL: false),
       let host = components.host,             // summer
       let pe = components.url?.pathExtension, // xml
       let items = components.queryItems,      // [lang=en]
       let fragment = components.fragment{     // 5
        print("DEBUG: host = '\(host)' and ...and path extension '\(pe)' and items '\(items)' and fragment given: '\(fragment)'")
        if let query = components.query {
            print("We select options (such as lang): '\(query)'.") // 'lang=en#5'
        }
        switch(host){
        case "summer":
            print("DEBUG: now open slides for summer...")
        default:
            print("DEBUG: now open slides other times..")
        }
        
    }
    
}

@main
struct omd_ios_devel_chapter_12_URLSchemesApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL { url in
                print("We handle the URL: \(url)")
                handleURLatAppStart(url)
            }
        }
    }
}
