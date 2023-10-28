//
//  ContentView.swift
//  omd-ios-devel-chapter-04-Data-Modelling
//
//  Created by John on 06.03.23.
//

import SwiftUI

struct ContentView: View {
    /*
    // better move to Unit Test:
    let sunsetSlide = Slide(title: "Sunset",
                  imgFileName: "sunset.png")
    */
    var body: some View {
        VStack {
            Spacer()
            Text("Data Modelling").font(.largeTitle)
            Spacer()
            Image(systemName: "info.circle")
                .imageScale(.large)
                .foregroundColor(.accentColor).padding(.all)
            Text("Check out the Swift code in subdirectory model and service")
            Spacer()
        }
        .padding()
        .onAppear(){
            /*
            // better move to Unit Test:
            print("The first slide \(sunsetSlide)")
            */
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
