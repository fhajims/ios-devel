//
//  ContentView.swift
//  omd-ios-devel-chapter-10-Sensors
//
//  Created by John on 21.12.22.
//

import SwiftUI

struct ContentView: View {
    enum Tabs:Int {
        case vibra, proxy, baro, gyro, accel
    }
    @State
    private var tb:Tabs = .gyro
    
    var body: some View {
        TabView(selection: $tb) {
            VibrationView().tabItem { Text("Vibra")}.tag(Tabs.vibra)
            ProximityView().tabItem { Text("Proximity") }.tag(Tabs.proxy)
            GyroscopeView().tabItem { Text("Gyro") }.tag(Tabs.gyro)
            AcceleratorView().tabItem { Text("Accel") }.tag(Tabs.accel)
            BarometerView().tabItem { Text("Baro") }.tag(Tabs.baro)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
