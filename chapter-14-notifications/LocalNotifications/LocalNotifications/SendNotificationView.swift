//
//  SendNotificationView.swift
//  Local Notifications
//
//  Created by John on 30.01.23.
//

import SwiftUI
import UserNotifications


struct SendNotificationView: View {
    @Environment(\.scenePhase) var scenePhase
    
    let scheduledTimeInSec=7
    @State
    var status:String = "-"
    
    @State
    var id:Int = 77
    
    @State
    var msg:String = "Please update your app in the app store to get the latest cool features..."
    
    @State var timeRemaining:Int = 0
    
    @State
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Local Notifications")
                .font(.title)
                .padding(.bottom)
            TextField(
                "Send following message",
                text: $msg
            ).padding(.all)
                .onSubmit {
                    print("todo...")
                }
            Button( action: scheduleNotification) {
                Text("Schedule notification")
            }
            Spacer()
            Text(status).multilineTextAlignment(.center).padding(.all)
        }.onReceive(timer ) { tmr in
            print("* Timer triggered \(tmr). (timeRemaining: \(timeRemaining)) *")
            switch timeRemaining {
            case 0:
                self.status = "-"
                timer.upstream.connect().cancel()
            default :
                timeRemaining -= 1
                self.status = "Notification has been scheduled to appear in about \(timeRemaining) secs. Move app in the background to receive the notification..."
                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
        }.onDisappear(){
            print("Note: only when view disapperas, not triggered on app moves to background")
        }.onAppear(){
            // cancel the timer (no default)
            print("Note: only when view appers, not triggered on app moves to foreground.")
            timer.upstream.connect().cancel()
        }.onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                print("...Scene phase switched to 'Active'.")
            } else if newPhase == .inactive {
                print("...Scene phase switched to 'InActive'.")
            } else if newPhase == .background {
                print("...Scene phase switched to 'Background'. We cancel the timer.")
                timer.upstream.connect().cancel()
                timeRemaining = scheduledTimeInSec
                status = "-"
            }
        }
        .padding()
    }
    func scheduleNotification(){
        Task {
            await scheduleNotificationAsync()
        }
    }
    func scheduleNotificationAsync() async{
        guard (timeRemaining == 0 ||
               timeRemaining == scheduledTimeInSec) else {
            print("Prevent scheduling multiple notifications")
            return
        }
        timeRemaining = scheduledTimeInSec
        
        print("We prepare event to appear in \(scheduledTimeInSec) secs...")
        status = "Adding Notification"
        let content = UNMutableNotificationContent()
        content.title = msg
        content.body = "Swift Coding Session"
        content.sound = UNNotificationSound.default
        content.badge = 7 // Note the batch "7" on the icon

        // Deliver the notification in seven seconds.
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(scheduledTimeInSec),
            repeats: false)
        
        // Schedule the notification:
        id += 1
        let request = UNNotificationRequest(
            identifier: "Notification-ID-\(id)", // unique notif-id
            content: content,
            trigger: trigger)
        
        // check iOS notification center in a few secs
        let center = UNUserNotificationCenter.current()
        
        // The first time your app makes this authorization request, the system prompts the user to grant or deny the request and records the user’s response. Subsequent authorization requests don’t prompt the user.
        
        guard let authorised = try? await center.requestAuthorization(options: [.alert, .sound, .badge]) else {
            Swift.print("ERR, not authorized")
            return
        }
        print("Authorization-Grant ok: \(authorised). Now check the current authorisation status for scheduling")
        let settings:UNNotificationSettings = await center.notificationSettings()
        
        guard (settings.authorizationStatus == .authorized) ||
                (settings.authorizationStatus == .provisional) else {
            print("Sorry, notifications have been denied by the user. Set permissions to allow notifications in Settings/Notifications.")
            status = "Allow notifications in settings."
            return
        }
        /*
         if settings.alertSetting == .enabled {
         print("TODO: We might schedule an alert-only notification...")
         } else {
         print("TODO: We might schedule a badge/sound notification...")
         }*/
        print("Everything ok. We schedule the notification now...")
        guard (try? await center.add(request)) != nil else {
            print("Sorry, we could not schedule the notification.")
            return
        }
        
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        self.status = "Notification has been scheduled to appear in about \(scheduledTimeInSec) secs. Move app in the background to receive the notification..."
    }
}


struct SendNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        SendNotificationView()
    }
}
