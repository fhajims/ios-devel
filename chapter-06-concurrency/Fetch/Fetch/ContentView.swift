//
//  ContentView.swift
//  omd-ios-devel-chapter-06-Fetch
//
//  Created by John on 05.09.23.
//

import SwiftUI

struct ContentView: View {
    let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Babisnauer_pappel_morgen.JPG/240px-Babisnauer_pappel_morgen.JPG")!
    var body: some View {
        VStack {
            
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Rectangle())
            } placeholder: {
                Image(systemName: "hourglass.bottomhalf.fill")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            Text("Sunrise near by Dresden (Germany) by Henry Mühlpfordt - Own work  CC BY-SA 3.0")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.all)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
