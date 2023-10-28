//
//  OverView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Navigation
//
//  Created by John on 24.01.23.
//

import SwiftUI

struct Overview: View{
    
    @Binding var currentTab:Int
    
    var body: some View{
        NavigationStack {
            VStack{
                
                Text("Ways to navigate").font(.title).padding()
                Form {
                    Section(header: Text("View and detail views")) {
                        Button("Present a detail view"){
                            currentTab=2
                        }
                    }
                    Section(header: Text("Popups")) {
                        Button("Show alerts"){
                            currentTab=3
                        }
                        Button("Overlay a sheet"){
                            currentTab=4
                        }
                    }
                    Section(header: Text("Advanced data-driven navigation")){
                        Button("Navigation stack"){
                            currentTab=5
                        }
                    }
                    Section(header: Text("Specials")){
                        Button("Hidden EasterEgg"){
                            currentTab=6
                            
                        }
                    }
                }
            }
        }
    }
}

struct OverView_Previews: PreviewProvider {
    @State
    static var startWithTabNo = 1
    
    static var previews: some View {
        Overview(currentTab: $startWithTabNo)
    }
}
