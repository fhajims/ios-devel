//
//  ListNotificatinView.swift
//  Local Notifications
//
//  Created by John on 30.01.23.
//

import SwiftUI
import NotificationCenter

struct Nots:  Identifiable, CustomStringConvertible {
    var description: String {
        title
    }
    
    let id: UUID = UUID()
    let title:String
}

struct ListNotificationView: View {
    
    @State
    var alreadyDeliveredNotifications:[Nots]
    
    @State
    var currentlyScheduledNotifications:[Nots]
    
    var body: some View {
        VStack{
            Text("List Notifications")
            GroupBox(label:
                        Text("Scheduled Notifications")
            ) {
                List(){
                    ForEach(currentlyScheduledNotifications){ n in
                        Text("\(n.title)")
                    }
                }
            }
            /*
            GroupBox(label:
                        Text("Delivered Notifications")
            ) {
                List(){
                    ForEach(alreadyDeliveredNotifications){ n in
                        Text("\(n.title)")
                    }
                }
            }
            Button(action: self.fillTheList){
                Text("refresh")
            }
             */
        }.task {
            await fillTheDeliveredNotificationListAsync()
            await fillThePendingNotificationListAsync()
        }
    }
    func fillTheList(){
        Task {
            await fillTheDeliveredNotificationListAsync()
            await fillThePendingNotificationListAsync()
        }
    }
    func fillTheDeliveredNotificationListAsync() async {
        let center = UNUserNotificationCenter.current()
        let deliveredNotifs: [UNNotification] = await center.deliveredNotifications()

        print("List of all delivered notifications:")
        
        print("Notifications: \(deliveredNotifs)")
        alreadyDeliveredNotifications.removeAll()
        deliveredNotifs.forEach(){ n in
            print("Delivered Notif: \(n.debugDescription)")
            alreadyDeliveredNotifications.append( Nots(title: n.description) )
        }

    }
    func fillThePendingNotificationListAsync() async {
        let center = UNUserNotificationCenter.current()
        
        // fetch the notifications concurrency with async/await
        let pendingNotifs: [UNNotificationRequest] = await center.pendingNotificationRequests()
        
        
        print("List of all scheduled notifications:")

        print("Notifications: \(pendingNotifs)")
        currentlyScheduledNotifications.removeAll()
        pendingNotifs.forEach(){ n in
            print("Scheduled Notif: \(n.debugDescription)")
            currentlyScheduledNotifications.append( Nots(title: "\(n.content.title) ( \( n.identifier ) )" ))
        }
    }
}

struct ListNotificatinView_Previews: PreviewProvider {
    static let demoDeliveredNots = [
        Nots(title: "You have been"),
        Nots(title: "remembered"),
    ]
    static let demoScheduledNots = [
        Nots(title: "Be aware"),
        Nots(title: "Something will happen"),
    ]
    static var previews: some View {
        ListNotificationView(alreadyDeliveredNotifications: demoDeliveredNots, currentlyScheduledNotifications: demoScheduledNots)
    }
}
