//
//  AcceleratorView.swift
//  omd-ios-devel-chapter-10-Sensors
//
//  Created by John on 22.12.22.
//

import SwiftUI

struct AcceleratorView: View {
    
    @State
    private var accPollingFrequency=3.0 // e.g. 3 ... trigger  3 times per second (after 1/3s).
    // Note:
    //    when Binding var $accPollingFrequency changes
    //    willSet / didSet is never triggered
    
    
    // Only ONE motion service per app!
    private let motionSrv:MotionService = MotionService.shared
    
    @ObservedObject var acc = MotionService.shared.accData
    
    var body: some View {
        VStack{
            Spacer()
            Text("Accelerometer").font(.title).padding(.bottom)
            Text("x=\(acc.x, specifier: "%0.05f" )")
            Text("y=\(acc.y, specifier: "%0.05f" )")
            Text("z=\(acc.z, specifier: "%0.05f" )")
            Spacer()
            Text("Polling/Update Frequency:")
            Text("\(accPollingFrequency, specifier: "%0.01f") times per Second")
            Slider(
                   value: $accPollingFrequency,
                   in: 1...20,
                   step: 0.5
               ) {
                   Text("Speed")
               } minimumValueLabel: {
                   Text("slow")
               } maximumValueLabel: {
                   Text("fast")
               } onEditingChanged: { editing in
                   print("DEBUG: update: \(accPollingFrequency)")
                   motionSrv.stopAccPolling()
                   motionSrv.startAccPolling( timesPerSecond: accPollingFrequency )

               }.padding(.all)
            Spacer()
        }
        .onAppear(){    motionSrv.startAccPolling( timesPerSecond: accPollingFrequency ) }
        .onDisappear() {motionSrv.stopAccPolling()  }
    }
}

struct AcceleratorView_Previews: PreviewProvider {
    static var previews: some View {
        AcceleratorView()
    }
}
