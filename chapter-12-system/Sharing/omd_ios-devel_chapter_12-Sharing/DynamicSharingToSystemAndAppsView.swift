//
//  DynamicSharingToSystemAndAppsView.swift
//  omd_ios-devel_chapter_12-Sharing
//
//  Created by John on 05.01.21.
//

import SwiftUI

struct SharingView: View {
    @State private var isShareTextPresented: Bool = false
    @State private var isShareURLPresented: Bool = false
    @State private var isShareImagePresented: Bool = false
    @State private var shareText = "Message to you: Everything is ok."
    private var shareURL = URL(string: "https://www.fh-joanneum.at")!
    private var shareImg = UIImage(named: "shareme")!
    
    var body: some View {
        VStack{
            Text("Sharing with 'whatever'...")
            Spacer()
            Divider()
            Text("System: Airdrop, Copy, SaveToFiles, Print, Shorten URL,...").multilineTextAlignment(.center)
            Text("Other Apps: Message, Skype, Books, MS-Teams, Moodle,...")
            VStack{
                Image("shareme")
                TextField("shareText",text: $shareText)
                Text("Show me the share options").font(.footnote)
                Divider()
            }
            
            HStack{
                Spacer()
                
                Image(systemName: "square.and.arrow.up").onTapGesture {
                    self.isShareURLPresented = true
                }.sheet(isPresented: $isShareURLPresented,
                        onDismiss: {
                            print("Dismissing the share activity sheet...")
                        },
                        content: {
                            CustomShareActivityViewController(
                                prepareActivityItems: [shareURL])
                        })
                Spacer()
                
                Image(systemName: "square.and.arrow.up").onTapGesture {
                    self.isShareImagePresented = true
                }.sheet(isPresented: $isShareImagePresented,
                        onDismiss: {
                            print("Dismissing the share activity sheet...")
                        },
                        content: {
                            CustomShareActivityViewController(
                                prepareActivityItems: [shareImg])
                        })
                Spacer()
                
                Image(systemName: "square.and.arrow.up").onTapGesture {
                    self.isShareTextPresented = true
                }.sheet(isPresented: $isShareTextPresented,
                        onDismiss: {
                            print("Dismissing the share activity sheet...")
                        },
                        content: {
                            CustomShareActivityViewController(
                                prepareActivityItems: [shareText])
                        })
                Spacer()
            }
            Spacer()
        }.multilineTextAlignment(.center)
        .padding(.leading, 12)
        .padding(.trailing, 12)
    }
}


struct CustomShareActivityViewController: UIViewControllerRepresentable {
    
    var prepareActivityItems: [Any]
    var prepareApplicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CustomShareActivityViewController>) -> UIActivityViewController {
        let ctrlr = UIActivityViewController(
            activityItems: prepareActivityItems, applicationActivities:prepareApplicationActivities)
        return ctrlr
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<CustomShareActivityViewController>) {
        // noting to do on update
        
    }
    
}
