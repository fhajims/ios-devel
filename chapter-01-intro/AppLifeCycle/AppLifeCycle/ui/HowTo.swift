//
//  HowTo.swift
//  1-AppLifeCycle
//
//  Created by John on 28.12.21.
//

import SwiftUI

struct HowTo: View {
    var body: some View {
        VStack {
            Text("App Life-Cycle\nHow To")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            Text("Create an init method for the app.")
                .padding(.bottom)
                .multilineTextAlignment(.center)
            Text("-- and / or --")
                .padding()
                .multilineTextAlignment(.center)
            Text("Put code in scene .onChange method. In this method check the scenePhase environment variable which reflects the current state of the app.")
                .padding(.bottom)
                .multilineTextAlignment(.center)
            Text("-- and / or --")
                .padding()
                .multilineTextAlignment(.center)
            Text("Put code in the view onAppear/onDisappear methods")
                .padding(.bottom)
                .multilineTextAlignment(.center)
        }.onAppear(){
            print("\(Date()): The HowTo view appeared.")
        }.onDisappear(){
            print("\(Date()): The HowTo view disappeared.")
        }
    }
}

struct HowTo_Previews: PreviewProvider {
    static var previews: some View {
        HowTo()
    }
}
