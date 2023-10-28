//
//  MailSharingView.swift
//  omd_ios-devel_chapter_12-Sharing
//
//  Created by John on 05.01.21.
//

import SwiftUI
import MessageUI



struct MailSharingView: View {

    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var weCanSendMail = MFMailComposeViewController.canSendMail()

    // Is the mailing view currently visible
    @State var isShowingMailView = false
    @State var showAlertNoTextGivenToSendMail = false
    @State var alertSendingMailNotSuppported = false

    @State var shareTextSubject="Info Message"
    @State var shareTextBody="Hi, I'm feeling fine"
    
    var body: some View {
        VStack{
        Spacer(minLength:2)
        Text("Share")
        Spacer()
            Text("Use a REAL device to share images and/or text with others.").multilineTextAlignment(.center)
            .padding()
        
            HStack{
                Text("Title:")
                TextField("Subject",text: $shareTextSubject)

            }.frame(width: 280, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            HStack{
                Text("Message:")
                TextField("Body",text: $shareTextBody)
            }.frame(width: 280, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            // tap the image
            Image(systemName: "envelope.circle").imageScale(.large).onTapGesture {
                print("Mailing...")
                self.isShowingMailView.toggle()
            }

            // or press the button
            Button("Share as eMail") {
                // let us enable/disable = show/hide the Mailing View
                print("Mailing...")
                if shareTextBody.isEmpty {
                    self.showAlertNoTextGivenToSendMail=true
                } else{
                    self.showAlertNoTextGivenToSendMail=false
                    
                    if MFMailComposeViewController.canSendMail() {
                        // using the built-in mail app
                       self.isShowingMailView.toggle()
                    } else {
                        // Alert about no way to send a mail
                       self.alertSendingMailNotSuppported.toggle()
                    }
                }
            }.alert(isPresented: self.$showAlertNoTextGivenToSendMail) {
                Alert(title: Text("First enter some text, then try again."))
            }
            .alert(isPresented: self.$alertSendingMailNotSuppported) {
                Alert(title: Text("Sorry, no mail configured."))
            }
            .disabled(!weCanSendMail)
            .sheet(isPresented: $isShowingMailView) {
                MailHelperView(subject: self.shareTextSubject,
                               body: self.shareTextBody,
                               result:self.$result)
            }
            Spacer()
            Button("Send mail using an external mail app\n (Gmail/Outlook/Yahoo/...)") {
               if let emailUrl = MailExternalURLsHelper.createEmailUrl(
                    app: UIApplication.shared,
                        subject: self.shareTextSubject,
                        body: self.shareTextBody) {
                    UIApplication.shared.open(emailUrl)
               }else {
                // Alert about no way to send a mail
                self.alertSendingMailNotSuppported.toggle()
            }
            }
        }.multilineTextAlignment(.center)
    }

}
