//
//  SMSSharing.swift
//  omd_ios-devel_chapter_12-Sharing
//
//  Created by John on 05.01.21.
//

import SwiftUI

// for sending Text Messages:
import MessageUI

struct SMSSharingView: View {
    
   private let messageComposeDelegate = TextMessageComposerDelegate()
    
    var body: some View {
        VStack{
            Text("SMS")
                .fontWeight(.black)
                .padding(.bottom)
            Button("Send the text message"){
                print("We open the Text Message (SMS) view...")
                self.showTextMessageComposeView()
            }
        }
    }
}


// MARK: The message extension
extension SMSSharingView {

    private class TextMessageComposerDelegate: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            print("Sending the text message, didFinish With result: '\(result)': '\(result.rawValue)'")
            // Customize here
            controller.dismiss(animated: true)
        }
    }
    /// Present an message compose view controller modally in UIKit environment
    private func showTextMessageComposeView() {
        guard MFMessageComposeViewController.canSendText() else {
            print("Sorry, this device can not send text messages (SMS).")
            return
        }
        let currentKeyWindow =
            // the app
            UIApplication.shared
            // all the scenes
            .connectedScenes
            // active, onscreen, visible scenes
            .filter { $0.activationState == .foregroundActive }
            // first UIWindowScene
            .first(where: { $0 is UIWindowScene })
            // associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // the one, which takes user input currently
            .first(where: \.isKeyWindow)
        let rootVc = currentKeyWindow?.rootViewController
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = messageComposeDelegate

        rootVc?.present(composeVC, animated: true)
    }
}



struct SMSSharingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SMSSharingView()
        }
    }
}
