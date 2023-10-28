//
//  MultipleInputView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Widgets
//
//  Created by John on 01.12.21.
//

import SwiftUI

let MAX_CHARS = 77 // max 77 chars

struct InputField:View{
    @Binding var email: String
    var body: some View{
        HStack{
            Text("Email:").padding(.leading)
            TextField("text: Enter", text: $email)
                .foregroundColor(.blue)
                //.background(.green)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle() )
            Spacer()
        }
    }
}

struct InputLargeText: View{
    @Binding var notes:String {
        didSet {
            // Note: only triggered in the case that notes is too long
            //       and set again to a new (truncated) string
            print("INFO: notes changed to '\(notes)'. I.e note was truncated to max chars of \(notes.count).")
        }
    }
    @Binding var len:Int
    
    var body: some View{
        VStack{
            HStack{
                Text("Personal notes:").font(.title2).padding(.top).padding(.leading)
                Spacer()
            }
            TextEditor(text: $notes).padding(.horizontal)
                .foregroundColor(.blue)
                .onChange(of: notes){ _ in
                    if notes.count > MAX_CHARS {
                        notes = String(notes.dropLast(notes.count - MAX_CHARS))
                    }
                    len=notes.count
                }
            ProgressView(value: Double(len)/Double(MAX_CHARS) )
                            .padding(.top, 20)
                            .accentColor(.pink)
            Text("\(MAX_CHARS-len) chars left.")
                .multilineTextAlignment(.trailing)
                .foregroundColor((MAX_CHARS-len) < 5 ? .red : .gray)
                .padding(.bottom)
        }
    }
}

struct SomeInputView: View {
    @State var email:String = "carl@wonder.org"
    @State var notes:String = """
We await your feedback.
Please contact us via "Social Media"
"""

    @State var len: Int = 0
    @State var acceptButtonIsDisabled = true
    @State var month: Int = 4
    var body: some View {
        VStack{
            Spacer()
            Text("My Profile")
                .fontWeight(.light)
                .font(.title)
                .padding()
            Spacer()
            InputField(email: $email)
            InputLargeText(notes: $notes,len: $len)
            
            Stepper(value: $month, in: 1...12) {
                Text("Remaind me again in \(month) month.")
            }.padding()
            Toggle(isOn: $acceptButtonIsDisabled) {
                Text("Accept all the terms and conditions")
            }.padding()
            Button("OK, let's share with others..") {
                print("TODO: Sharing button was tapped, so send some info...")
            }.disabled(!acceptButtonIsDisabled).padding()
            Link(destination: URL(string: "https://my.server.org/agb")! ) {
                Text("AGB")
            }.disabled(!acceptButtonIsDisabled).padding()
            Spacer()
        }.onAppear {
            len = notes.lengthOfBytes(using: .utf8)
        }
    }
}

struct SomeInputView_Previews: PreviewProvider {
    static var previews: some View {
        SomeInputView()
        SomeInputView().preferredColorScheme(.dark)
        
    }
}
