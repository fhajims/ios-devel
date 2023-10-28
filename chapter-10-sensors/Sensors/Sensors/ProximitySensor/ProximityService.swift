//
//  ProximityService.swift
//  omd-ios-devel-chapter-10-Sensors
//
//  Created by John on 22.12.22.
//

import Foundation
import UIKit



class ProximityService {
    
    // nested/inner class for the observer:
    //   because the "Notification Center" will
    //   inform the ProximityObserver will trigger the 'didChange' method
    //   on proximity change events
    class ProximityObserver:ObservableObject {
        @Published
        var state = "-" {
            didSet {
                print("DEBUG I: State changed to: \(state)")
            }
        }
        
        @objc
        func didChange(notification: NSNotification) {
            // we get notification with name, object, and userInfo
            // here we check:
            //  if the notification sent, holds some infos on a "device"
            //  casting variable of general type 'object' to type 'UIDevice'
            //  for accessing (the lately changed) 'proximityState' variable see below
            guard let device = notification.object as? UIDevice else { return }
            
            state = device.proximityState ? "near": "far"
        }
    }
    // and we create an instance of an observer (which can handle changes device
    public var proximityObserver = ProximityObserver()
    

    // Singleton:
    //   private init and
    //   an instance named 'shared'
    private init(){
        print("DEBUG I: We want one, and only one proximity service for our app.")
    }
    static let shared = ProximityService()
    
    // activate / deactivate
    //   called on showing/hiding the UI / view
    func activate(){
        UIDevice.current.isProximityMonitoringEnabled = true
        
        // as some devices might not have proximity hardware
        // i.e. the value stays false
        // and it would make no sense to set up notifications
        guard UIDevice.current.isProximityMonitoringEnabled else { return }

        print("DEBUG I: Switching observation ON (ie. register the observer).")
        
        // registering 'callbacks' (i.e. observers and a method to call)
        //    at the global so called "NotificationCenter"
        // to listen for an event (here: 'proximityStateDidChangeNotification')
        //    sent from given objects (here the current "device", i.e. iPhone/iPad)
        NotificationCenter
            .default
            .addObserver(
                proximityObserver,  // observerobject = an object with an @objc method
                                    // the name of the @objc method is specified below
                                    // (here: 'didChange'
                                    //    this has to be a method which accepts
                                    //    a single parameter of Type 'NSNotification')
                selector: #selector(proximityObserver.didChange), // call this method on event
                name: UIDevice.proximityStateDidChangeNotification, // name to filter notifications
                object: UIDevice.current // object that will send notification to the observer
            )
         
    }
    func deactivate(){
        UIDevice.current.isProximityMonitoringEnabled = false
        
        print("DEBUG I: Switching observation OFF (ie. unregister the observer).")
        // unregister the 'callbacks', i.e. remove the observer
        //   for given event (here "proximity change")
        //   from given object (here iPhone/iPad "device")
        NotificationCenter
            .default
            .removeObserver(
                proximityObserver,
                name: UIDevice.proximityStateDidChangeNotification,
                object: UIDevice.current)
    }
}
