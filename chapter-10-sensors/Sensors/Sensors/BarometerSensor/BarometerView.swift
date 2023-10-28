//
//  BarometerView.swift
//  omd-ios-devel-chapter-10-Sensors
//
//  Created by John on 22.12.22.
//

import SwiftUI


struct BarometerView: View {
    // Note: the instance was created at App start
    //       in file "SensorApp.swift"
    // Injected instance (object) of type BaroService
    @EnvironmentObject var baroService:BaroService
    
    var body: some View {
        VStack{
            Text("Barometer:").font(.title2).padding(.bottom)
            Text(baroService.barometerValue)
            Text(baroService.relativeAltitude)
        }.onAppear {    baroService.start() }
            .onDisappear { baroService.stop() }
    }
}

struct BarometerView_Previews: PreviewProvider {
    static let baroService = BaroService()
    
    static var previews: some View {
        BarometerView().environmentObject(baroService)
    }
}
