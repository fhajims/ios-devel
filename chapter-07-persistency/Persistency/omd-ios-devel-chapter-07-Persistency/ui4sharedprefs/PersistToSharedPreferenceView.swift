//
//  PersistToSharedPreferenceView.swift
//  omd-ios-devel-chapter-07-Persistency
//
//  Created by john on 16.02.22.
//

import SwiftUI

struct PersistToSharedPreferenceView: View {
    
    // preserve any changes, ie. store to shared prefs:
    
    @AppStorage("email")
    private var email: String = "?"
    
    
    var body: some View {
        VStack{
            Text("Persist to Prefs").font(.title).padding()
            NavigationView {
                VStack{
                    Text("Enter an email, and it will be preserved:")
                    TextField("eMail",text: $email).padding(.horizontal)
                    NavigationLink(destination: PersistToSharedPrefsHowToView()) {
                        Text("How to")
                    }
                    
                }
            }
        }
    }
}

struct PersistToSharedPreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PersistToSharedPreferenceView()
    }
}
