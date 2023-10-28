//
//  PesristToSharedPrefsHowToView.swift
//  omd-ios-devel-chapter-07-Persistency
//
//  Created by john on 16.02.22.
//

import SwiftUI

struct PersistToSharedPrefsHowToView: View {
    
    @AppStorage("email")
    private var userEmail: String = "-not-set-"
    
    var body: some View {
        VStack{
            Text("How to use the shared prefs key value store:").multilineTextAlignment(.leading)
            Text("Annotate your variable with '@AppStorage'.")
            Spacer()
            Text("Hello \(userEmail)!")
        }
    }
}

struct PesristToSharedPrefsHowToView_Previews: PreviewProvider {
    static var previews: some View {
        PersistToSharedPrefsHowToView()
    }
}
