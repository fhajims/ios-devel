//
//  MotionService.swift
//  omd-ios-devel-chapter-10-Sensors
//
//  Created by John on 22.12.22.
//

import Foundation
import CoreMotion

class MotionService {
    // Singleton:
    private init(){}
    static let shared = MotionService()
    
    // MARK: - For both Gyroscope and Accelerator
    // only ONE CoreMotion motion manager per app!!
    private let motion = CMMotionManager()

    // MARK: - for the Gyro
    private var gyroTimer:Timer? = nil
    public var gyroData = GyroData()
    class GyroData:ObservableObject {
        @Published var x:Double=0.0
        @Published var y:Double=0.0
        @Published var z:Double=0.0
    }
    
    // MARK: - For the Accelerator
    class AccData:ObservableObject {
        @Published var x:Double=0.0
        @Published var y:Double=0.0
        @Published var z:Double=0.0
    }
    public var accData = AccData()
    private var accTimer:Timer? = nil
}



// MARK: - Extend class to add some methods for Gyroscope

extension MotionService {
    func startGyroPolling(timesPerSecond tmout:Double=1.0){
        guard motion.isGyroAvailable else {
            print("ERR: gyro not available")
            return
        }
        let numberOfSecBetweenGyroTimer = 1.0 / Double(tmout)
        self.motion.gyroUpdateInterval =  numberOfSecBetweenGyroTimer
        self.motion.startGyroUpdates()
        
        // Creat a new timer and
        // configure a timer to fetch the accelerometer data x-times a second.
        self.gyroTimer = Timer(fire: Date(),
                               interval:  numberOfSecBetweenGyroTimer,
                               repeats: true, block: { _ in //(timer) in
            
            // this code block is the handler routine
            // i.e. code executed, when timer triggered
            
            print("DEBUG \(Date()) we got: \(self.motion.gyroData.debugDescription)")
            guard let data = self.motion.gyroData else {
                return
                
            }
            self.gyroData.x =  data.rotationRate.x
            self.gyroData.y =  data.rotationRate.y
            self.gyroData.z =  data.rotationRate.z
        })
        
        
        guard let tmr = self.gyroTimer else {
            print("ERR: could not setup a timer")
            return
        }
        
        print("Debug I: We configured a timer (to trigger \(tmout) x per second.")
        
        // Add the timer to the current run loop.
        // Note: the RunLoop processes mouse/keyboard/timer events
        //       RunLoop.current = RunLoop for current thread
        //       RunLoop.Mode for handling "special" input sources (e.g. timer, modal windows, ...)
        //       here: Mode.default for handling timer input
        RunLoop.current.add(tmr, forMode: RunLoop.Mode.default)
    }
    
    func stopGyroPolling(){
        guard let tmr = self.gyroTimer else {
            print("Debug: nothing to do")
            return
        }
        print("Debug I: Removing the timer...")
        tmr.invalidate()
        self.gyroTimer = nil
        self.motion.stopGyroUpdates()
    }
}

// MARK: - Extend class to add some methods for Accelerator
extension MotionService {
    func startAccPolling(timesPerSecond tmout:Double=1.0){
        guard motion.isAccelerometerAvailable else {
            print("ERR: accelerometer not available")
            return
        }
        let numberOfSecBetweenAccTimer = 1.0 / Double(tmout)
        self.motion.accelerometerUpdateInterval =  numberOfSecBetweenAccTimer
        self.motion.startAccelerometerUpdates()
        
        // Creat a new timer and
        // configure a timer to fetch the accelerometer data x-times a second.
        self.accTimer = Timer(fire: Date(),
                                    interval:  numberOfSecBetweenAccTimer,
                                    repeats: true, block: { _ in
            // this code block is the handler routine
            // i.e. code executed, when timer triggered
            print("DEBUG \(Date()) we got: \(self.motion.accelerometerData.debugDescription)")
            guard let data = self.motion.accelerometerData else { return }
            self.accData.x =  data.acceleration.x
            self.accData.y =  data.acceleration.y
            self.accData.z =  data.acceleration.z
        })
        
        
        guard let tmr = self.accTimer else {
            print("ERR: could not setup a timer")
            return
        }
        
        print("Debug I: We configured a timer (to trigger \(tmout) x per second.")
        
        // Add the timer to the current run loop.
        // Note: the RunLoop processes mouse/keyboard/timer events
        //       RunLoop.current = RunLoop for current thread
        //       RunLoop.Mode for handling "special" input sources (e.g. timer, modal windows, ...)
        //       here: Mode.default for handling timer input
        RunLoop.current.add(tmr, forMode: RunLoop.Mode.default)
    }
    
    func stopAccPolling(){
        guard let tmr = self.accTimer else {
            print("Debug: nothing to do")
            return
        }
        print("Debug I: Removing the timer...")
        tmr.invalidate()
        self.accTimer = nil
        self.motion.stopAccelerometerUpdates()
    }
}
