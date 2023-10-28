//
//  ContentView.swift
//  omd-ios-devel-chapter-01-PackageManager
//
//  Created by john on 30.11.21.
//

import SwiftUI

// After adding a library such as:
// http://github.com/quanshousio/ToastUI

// For your info, the downloaded sources of the
// package can be found in a subdirectory of DerivedData in your home directory, such as:
//  ~/Library/Developer/Xcode/DerivedData/omd-ios-devel-chapter-01-PackageManager-bsebrbaesehxfsejqjfqvvgpmbno/SourcePackages/checkouts/ToastUI
// Select the package dependency and right-click "Show in Finder"


// You might use the new functionality. E.g.:
import ToastUI

struct ContentView: View {
    
    @State private var presentingToast: Bool = false
    
    var body: some View {
        VStack {
            Text("How to add libraries using the Swift package manager")
                .padding()
                .multilineTextAlignment(.center)
                .font(.title)
            Spacer()
            Text("Step 1 \nFrom the File menu, select 'Add Packages...'")
                .multilineTextAlignment(.center)
            Text("Step 2 \nIn the top right box enter an URL, such as https://github.com/quanshousio/ToastUI to add the package.")
                .multilineTextAlignment(.center)
                .padding(.all)
            Spacer()
            
            Button {
                presentingToast = true
            } label: {
                Text("Tap to show Infos")
            }.toast(isPresented: $presentingToast) {
                ToastView {
                    VStack{
                        Text("See http://github.com/quanshousio/ToastUI for more information on ToastUI")
                        Button {
                            presentingToast = false
                        } label: {
                            Text("Close")
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
