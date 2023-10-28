//
//  ContentView.swift
//  omd-ios-devel-chapter-01-AppLifeCycle
//
//  Created by John on 28.12.21.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("App Life Cycle!")
                    .font(.title)
                    .padding()
                Text("Check out the Xcode console to view the timestamps of app life cycle callbacks")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                NavigationLink(destination: HowTo()) {
                    Text("How To").padding(.top)
                }
                Spacer()
                Text("Now go to the 'Home' screen and then open this app again...")
            }.onAppear(){
                print("\(Date()): The main view appeared.")
            }.onDisappear(){
                print("\(Date()): The main view disappeared.")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
