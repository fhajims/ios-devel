//
//  ContentView.swift
//  omd-ios-devel-chapter-05-Localisation
//
//  Created by John on 03.12.21.
//

import SwiftUI

// Open "Canvas" and preview
//      the content view
//      rendered with text in multiple langauges
//      at the same time

struct ContentView: View {
    var body: some View {
        VStack{
            // exactly the same:
            Text(NSLocalizedString("Hello world", comment: "why?"))
                .padding()
            Text("Hello world")
                .padding()
        }.onAppear(){
            // It makes more sense to
            // use translation from code
            let messageInE = "hello" // key to look up in *.strings files
            let msg = NSLocalizedString(messageInE, comment: "Check, if available in Localizable.strings (English)")
            print("String '\(messageInE)' was localised to '\(msg)'...")
            print(msg.uppercased()) // modify / work with text
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView().environment(\.locale, .init(identifier: "en-UK")) // de, en, en-GB
            ContentView().environment(\.locale, .init(identifier: "de-AT"))
        }
    }
}
