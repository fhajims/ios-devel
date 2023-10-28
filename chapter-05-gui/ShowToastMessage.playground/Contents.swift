//: A UIKit based Playground for presenting user interface

import SwiftUI
import PlaygroundSupport

struct MyExperimentalView: View {
    @State private var showNow = false
    @State private var state="No action triggered so far."
    var body: some View {
        VStack(){
            Spacer()
            Text("You want to clear tmp directory?")
            Spacer()
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
            Spacer()
            Text("Status: \(state)")
        }
    }
}

let view = MyExperimentalView()
PlaygroundPage.current.setLiveView(view)
