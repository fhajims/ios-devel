//
//  ContentView.swift
//  omd-ios-devel-chapter-12-ConnectionStatus
//
//  Created by John on 05.09.23.
//

import SwiftUI
import Network

struct ContentView: View {
    @State
    private var connected:Bool = false
    
    let m = NWPathMonitor(requiredInterfaceType: .cellular)
    let queue = DispatchQueue(label: "Monitor")
    
    var body: some View {
        VStack {
            Spacer()
            Text("Network Connection Status")
                .font(.title)
                .padding(.all)
                .multilineTextAlignment(.center)
            Text("Cellular-connected: \(connected ? "YES": "NO")")
            Spacer()
            Text("Run on a real device. Switch cellular connection on and off.")
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
        }
        .padding()
        .onAppear(){
            print("Setup monitor...")
            m.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    print("We're connected!")
                    Task {
                        self.connected = true
                    }
                } else {
                    print("No connection.")
                    self.connected = false
                }
                print("expensive: \(path.isExpensive)")
            }
            m.start(queue: queue)
        }.onDisappear(){
            m.cancel()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
