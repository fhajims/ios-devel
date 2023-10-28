//
//  Ways-One.swift
//  omd_ios-devel_chapter_12-URLSchemes
//
//  Created by John on 29.12.21.
//

import SwiftUI

// to open external URL in Safari
let urlString = "https://www.fh-joanneum.at/"
func openTheUrl(){
    print("open URL: \(urlString)...")
    guard let url = URL(string: urlString)else{
        print("Err: '\(urlString)' is not a valid url)")
        return
    }
    
    UIApplication.shared.open(url) { (result) in
        if result {
            print("ok, it worked: \(result)")
        }
    }
}

struct WayOneView: View {
    var body: some View {
        VStack{
            Text("Way 1 to open an URL").font(.largeTitle).padding()
            Text("Open url via UIApplication.shared.open()")
                .fontWeight(.heavy)
                .padding(.bottom)
            Button(urlString) {
                openTheUrl() // will open in system browser
            }
        }
    }
}

struct WayOneView_Previews: PreviewProvider {
    static var previews: some View {
        WayOneView()
    }
}
