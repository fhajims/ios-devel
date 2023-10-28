//
//  Proximity.swift
//  omd-ios-devel-chapter-10-Sensors
//
//  Created by John on 22.12.22.
//

import SwiftUI


struct ProximityView: View {
    
    private let prxmtySrv:ProximityService = ProximityService.shared
    
    @ObservedObject var observ = ProximityService.shared.proximityObserver
    
    var body: some View {
        VStack {
            Text("Proximity")
                .padding(.bottom)
                .font(.title)
                
            Text("Now swipe with your hand over the proximity sensor on your device").multilineTextAlignment(.center).padding(.horizontal).foregroundColor(.gray)
            Text(observ.state).controlSize(.mini)
        }
        .onAppear() {
            prxmtySrv.activate()
        }.onDisappear() {
            prxmtySrv.deactivate()
        }
    }
}

struct Proximity_Previews: PreviewProvider {
    static var previews: some View {
        ProximityView()
    }
}
