//
//  HowToView.swift
//  omd_ios-devel_chapter_12-URLSchemes
//
//  Created by John on 29.12.21.
//

import SwiftUI

struct HowToView: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack{
            Spacer()
            Text("How To")
                .font(.largeTitle)
            Spacer()
            Text("1 register URL Scheme such as swiftuislideshow in Info.plist").padding()
            Text("2 provide callback on open.").padding()
            Text("3 Open in a (mail) message or in browser an URL such as swiftuislideshow://summer/?2030#3 which deep links into your app")
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: { dismiss() }) {Text("Close")}
        }
        .padding(.horizontal)
    }
}

struct HowToView_Previews: PreviewProvider {
    static var previews: some View {
        HowToView()
    }
}
