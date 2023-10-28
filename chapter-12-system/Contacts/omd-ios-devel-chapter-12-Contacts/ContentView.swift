//
//  ContentView.swift
//  omd-ios-devel-chapter-12-Contacts
//
//  Created by John on 05.01.22.
//

import SwiftUI

struct ContentView: View {
    private let mgmt = ContactManagement.shared
    
    @State
    private var friends:[Friend]=[]
    var body: some View {
        VStack{
            Text("Your Contacts")
                .font(.largeTitle)
            Text("Search your personal address book.")
                .padding()
            List {
                ForEach(friends){ friend in
                    Text(friend.name)
                }
            }
        }.task {
            friends = await mgmt.fetchSomeContacts()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
