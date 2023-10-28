//
//  AlertsView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Navigation
//
//  Created by john on 19.01.22.
//

import SwiftUI

struct AlertsView: View {
    @State private var showNow = false
    @State private var state="No action triggered so far."
    
    var body: some View {
        VStack{
            Text("Warning")
                .font(.title)
                .padding()
            Text("You want to clean up the tmp directory?")
                .foregroundColor(.red)
                .padding(.vertical)
                
            
            Button("Yes") {
                print("First, confirm to clean up the tmp directory!")
                state="Better ask what to do..."
                showNow=true
            }.alert("You are really sure to clean the tmp dir?", isPresented: $showNow) {
                HStack{
                    Spacer()
                    Button("Clean", role: .destructive){
                        print("Clean now...")
                        state="Cleaned"
                    }
                    .padding()
                    Button("Cancel", role: .cancel){
                        print("Abort cleaning.")
                        state="Aborted"
                    }
                    Spacer()
                }
                
            }
            Spacer()
            switch  state {
            case "Cleaned":
                Text("Fine, let's start to clean up.")
                    .padding(.all)
                    .multilineTextAlignment(.center)
            case "Aborted":
                Text("Ok, we do NOT dare to clean the tmp dir: \(state).")
                    .padding(.all)
                    .multilineTextAlignment(.center)
            default:
                Spacer()
            }
        }
        // Optionally, we might trigger some code, when
        //   a value within the view changes
        .onChange(of: showNow) { _, sn in
            print("FYI: status of variable showNow  changed to new value: '\(sn)'. ")
        }
        .onAppear(perform: { state="undefined"})
    }
}

struct AlertsView_Previews: PreviewProvider {
    static var previews: some View {
        AlertsView()
    }
}
