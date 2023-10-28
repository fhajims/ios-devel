//
//  ContentView.swift
//  omd-ios-devel-chapter-05-UnitTesting
//
//  Created by John on 03.12.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Unit Tests")
                .font(.largeTitle)
                .padding()
            Text("Developer, run target UnitTesting and view command line output!")
                .multilineTextAlignment(.center)
                .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
