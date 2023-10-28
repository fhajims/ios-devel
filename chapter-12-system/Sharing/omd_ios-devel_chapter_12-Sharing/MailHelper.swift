//
//  MailHelper.swift
//  omd_ios-devel_chapter_12-Sharing
//
//  Created by John on 05.01.21.
//

import SwiftUI
import MessageUI


// Note: import MessageUI
// class must implement methods from
// MFMailComposeViewControllerDelegate


// Helper View for sending mail:

struct MailHelperView: UIViewControllerRepresentable {
    @State var subject:String
    @State var body:String
    @Binding var result: Result<MFMailComposeResult, Error>?
    @Environment(\.presentationMode) var presentation
    
    
    // Note 1/2 on Protocol UIViewControllerRepresentable
    //     requires to MAKE = create the view controller object and configures its initial state.
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailHelperView>) -> MFMailComposeViewController {
        // OK, but too simple
        // return MFMailComposeViewController()

        // To forward changes to other views we need a coordinator (see below!)

        let mailComposeViewController = MFMailComposeViewController()
        // we fill some values (as far as we know): subject and body and ...
        mailComposeViewController.setSubject(subject)
        mailComposeViewController.setMessageBody(body, isHTML: false)
        // we are the delegate
        mailComposeViewController.mailComposeDelegate = context.coordinator
        return mailComposeViewController
    }

    // Note 2/2 on Protocol UIViewControllerRepresentable
    //     requires to UPDATE state of the specified view controller with
    //     new information from SwiftUI

    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                  context: UIViewControllerRepresentableContext<MailHelperView>) {
        // nothing to do during an update

    }
    
    // see Apple Developer Documentation
    //  When you want your view controller to coordinate with other
    //  SwiftUI views, you must provide a Coordinator instance to
    //  facilitate those interactions. For example, you use a coordinator
    //  to forward target-action and delegate messages from your view
    //  controller to any SwiftUI views.
    
    class InternalMailCoordinator: NSObject, MFMailComposeViewControllerDelegate{
        // internal variables, get/set values on initialisation
        // PresentationMode = An indication whether a view is currently presented by another view.
        //                   later we call .dismiss()
        @Binding var presentMode: PresentationMode
        @Binding var resultVal: Result<MFMailComposeResult, Error>?
        
        // init the class with proper arguments
        init(presentationMode: Binding<PresentationMode>,
             resultValue: Binding<Result<MFMailComposeResult, Error>?>){
            
            // initialising our custom created coordinator
            self._presentMode = presentationMode
            self._resultVal = resultValue
        }
        
        // The protocol MFMailComposeViewControllerDelegate
        // has optional method to respond to email completion
        //     we finish with result of MFMailComposeResult:
        //     cancelled = 0, saved = 1, case sent = 2, failed = 3
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            // in any case ("finally", whatever might happen) dismiss the view
            defer {
                // wrapped Value exposes the underlying value
                // referenced by the binding variable (here: $presentMode)
                $presentMode.wrappedValue.dismiss()
            }
            guard error == nil else {
                print("ERR when sending mail: '\(String(describing: error).debugDescription)'.")
                self.resultVal = Result.failure(error!)
                return
            }
            
            // everything went ok (saving as draft and cancelling is ok, too):
            print("Successfully 2=sent/1=saved/0=cancelled mail: '\(result.rawValue)'...")
            self.resultVal = Result.success(result)
        }
        
        
        
    }
    
        func makeCoordinator() -> InternalMailCoordinator {
            return InternalMailCoordinator(
                presentationMode: presentation,
                resultValue: $result)
        }

    
    
}

