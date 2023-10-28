//
//  LoginFormSwiftUIView.swift
//  omd-ios-devel-chapter-02-UnitTesting
//
//  Created by John on 31.01.23.
//

import SwiftUI

struct LoginFormView: View {
    
    @State var email = ""
    @State var password = ""
    @State private var showLogin = false

    
    
    var body: some View {
        
        VStack {
            Text("Registration")
                .font(.title)
            Form {
                Section {
                    TextField("Email", text: $email) .accessibilityIdentifier("form_email")
                    SecureField("Password", text: $password)
                        .accessibilityIdentifier("form_password")
                }
                HStack{
                    Spacer()
                    Button(action: {
                        print("TODO execute the login... ")
                    }, label: {
                        Text("Login")
                    }).disabled(!showLogin)
                }
            }.onChange(of: email) {
                mimimalValidationOfUserNamePassword()
            }.onChange(of: password) {
                mimimalValidationOfUserNamePassword()
            }
        }
        .padding()
    }
    func mimimalValidationOfUserNamePassword(){
        showLogin = email.count > 2 && password.count > 2
    }
}

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView()
    }
}
