//
//  ContentView.swift
//  TAoE-051
//
//  Created by John on 06.03.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("TAoE\nThe Art of Error").multilineTextAlignment(.center).font(.largeTitle)
                .padding()
            
            Text("What is wrong with this code?")
                .foregroundColor(.black)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
