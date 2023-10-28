//
//  BarometerService.swift
//  omd-ios-devel-chapter-10-Sensors
//
//  Created by John on 22.12.22.
//

import Foundation
import CoreMotion


class BaroService:ObservableObject {
    @Published var barometerValue:String = "-"
    @Published var relativeAltitude:String = "-"
    
    let altimeter = CMAltimeter()
    
    public func start(){
        guard CMAltimeter.isRelativeAltitudeAvailable() else {
            barometerValue = "Sorry, no air pressure available."
            print("ERR: Barometer not available on this device.")
            return
        }
        
        
        self.barometerValue = "We start polling the barometer..."
        // Note:
        //   ...Core Motion generates events
        //      at regular intervals
        //      (regardless of whether the data has changed)...
        altimeter.startRelativeAltitudeUpdates(to: OperationQueue.current!) {
            (data, error) in
            guard error == nil,
                  let data = data else {
                print("ERR: \(error.debugDescription )")
                self.barometerValue = "-"
                self.relativeAltitude = "-"
                return
            }
            
            // we got (possibly updated) values:
            
            //  Airpressure in kilopascals
            //  Note: the data.pressure is of type "NSNumber"
            //        which is a wrapper (C scalar)
            //        to primitive scalar numeric values
            //        i.e. signed char, unsigned char,
            //             short int, int, long int, long long int,
            //             float, double, BOOL
            let currPressure = String(
                format: "%7.03f", data.pressure.floatValue )
            self.barometerValue = "Pressure: \(currPressure) kilopascals"
            
            // Elevation change (= relative altitude) since start:
            let relVal = String(
                format: "%0.02f", data.relativeAltitude.floatValue )
            self.relativeAltitude = "Since start: Δm = \(relVal)m"
        }
    }
    public func stop(){
        altimeter.stopRelativeAltitudeUpdates()
        self.barometerValue = "stopped"
        self.relativeAltitude = ""
    }
}
