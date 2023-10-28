//
//  ContentView.swift
//  omd-ios-devel-chapter-07-Persistency
//
//  Created by John on 03.11.21.
//

import SwiftUI
import CoreData


struct ContentView: View {
        
    @State private var currTabIdx = 0;
    var body: some View {
        TabView(selection: $currTabIdx) {
            
            PersistToSharedPreferenceView().tabItem { Text("Prefs") }.tag(2)
            
            SlidesFromDBView()
                .tabItem { Text("DB") }.tag(1)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static let persistenceController = PersistenceController.shared
    
    static var previews: some View {
        
        ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            
    }
}
