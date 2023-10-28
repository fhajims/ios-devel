//
//  VibrationView.swift
//  omd-ios-devel-chapter-10-Sensors
//
//  Created by John on 22.12.22.
//

import SwiftUI
import AVFoundation

struct VibrationView: View {
    enum Using {
        case ImpactFeedback, AudioService, NotificationService
    }
    enum Pattern{
        case warn, err, succ
        func toNotifFeedbkType() -> UINotificationFeedbackGenerator.FeedbackType {
            switch(self){
            case .warn: return UINotificationFeedbackGenerator.FeedbackType.warning
            case .err: return UINotificationFeedbackGenerator.FeedbackType.error
            case .succ: return UINotificationFeedbackGenerator.FeedbackType.success
            }
        }
    }

    func vibrate(using: Using, pattern p:Pattern = Pattern.warn) {
        switch(using) {
        case .ImpactFeedback:
            UIImpactFeedbackGenerator(
                style: .heavy) // .light .medium .rigit .soft
                .impactOccurred()
        case .AudioService:
            // create/get a system sound
            //    using "AudioServicesCreateSystemSoundID"
            // or use a built-in ID
            //    e.g.: "kSystemSoundID_Vibrate"
            AudioServicesPlaySystemSound(
                kSystemSoundID_Vibrate // the system sound id
            )
        case .NotificationService:
            // error, success or warning info feedback:
            UINotificationFeedbackGenerator()
                .notificationOccurred(
                    p.toNotifFeedbkType()  // .error .success
            )
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Vibrate").font(.title)
            Button("Impact Feedback",
                   action: { vibrate(using: .ImpactFeedback)})
                .padding()
            Button("Audio Services",
                   action: { vibrate(using: .AudioService)})
                .padding()
            Spacer()
            Text("Notification Feedback")
            HStack {
                Button("Error",
                       action: { vibrate(using: .NotificationService,
                                         pattern: .err)})
                Button("Warning",
                       action: { vibrate(using: .NotificationService)})
                
                Button("Success",
                       action: { vibrate(using: .NotificationService,
                                         pattern: .succ)})
            }
                .padding()
        }
    }
}
struct VibrationView_Previews: PreviewProvider {
    static var previews: some View {
        VibrationView()
    }
}
