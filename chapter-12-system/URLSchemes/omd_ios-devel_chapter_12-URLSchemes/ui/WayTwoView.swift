//
//  WayTwoView.swift
//  omd_ios-devel_chapter_12-URLSchemes
//
//  Created by John on 29.12.21.
//

import SwiftUI

struct WayTwoView: View {
    @Environment(\.openURL) var openMyURL
    
    var body: some View {
        VStack {
            Text("Way 2 to open an URL")
                .font(.largeTitle).padding()
            Text("Open the url via 'Environment'.")
                .fontWeight(.heavy)
                .padding(.bottom)
            Button(action: contactSupport) {
                Text("Visit Imprint")
                Image(systemName: "network")
            }.padding()
            
        }
        
    }
    
    func contactSupport() {
        guard let url = URL(string: "https://www.fh-joanneum.at/en/university/organisation/imprint/") else {
            return
        }
        openMyURL(url)
    }
    
}

struct WayTwoView_Previews: PreviewProvider {
    static var previews: some View {
        WayTwoView()
    }
}
