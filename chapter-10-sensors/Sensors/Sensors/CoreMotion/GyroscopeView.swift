//
//  AcceleratorView.swift
//  omd-ios-devel-chapter-10-Sensors
//
//  Created by John on 22.12.22.
//

import SwiftUI

struct GyroscopeView: View {
    @State
    private var gyroPollingFrequency=3.0 // e.g. 3 ... trigger  3 times per second (after 1/3s).
    // Note:
    //    when Binding var $gyroPollingFrequency changes
    //    willSet / didSet is never triggered
    
    
    // Only ONE motion service per app!
    private let motionSrv:MotionService = MotionService.shared
    
    @ObservedObject var gyro = MotionService.shared.gyroData
    
    var body: some View {
        VStack{
            Spacer()
            Text("Gyroscope").font(.title).padding(.bottom)
            Text("x=\(gyro.x, specifier: "%0.05f" )")
            Text("y=\(gyro.y, specifier: "%0.05f" )")
            Text("z=\(gyro.z, specifier: "%0.05f" )")
            Spacer()
            Text("Polling/Update Frequency:")
            Text("\(gyroPollingFrequency, specifier: "%0.01f") times per Second")
            Slider(
                   value: $gyroPollingFrequency,
                   in: 1...20,
                   step: 0.5
               ) {
                   Text("Speed")
               } minimumValueLabel: {
                   Text("slow")
               } maximumValueLabel: {
                   Text("fast")
               } onEditingChanged: { editing in
                   print("DEBUG: update: \(gyroPollingFrequency)")
                   motionSrv.stopGyroPolling()
                   motionSrv.startGyroPolling( timesPerSecond: gyroPollingFrequency )

               }.padding(.all)
            Spacer()
        }
        .onAppear(){    motionSrv.startGyroPolling( timesPerSecond: gyroPollingFrequency ) }
        .onDisappear() {motionSrv.stopGyroPolling()  }
    }
}

struct GyroscopeView_Previews: PreviewProvider {
    static var previews: some View {
        GyroscopeView()
    }
}
