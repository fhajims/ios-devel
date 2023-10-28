//
//  ContentView.swift
//  omd-ios-devel-chapter-05-SwiftUI-DataBinding
//
//  Created by John on 19.01.22.
//

import SwiftUI

struct OverviewView: View {
    var titleColor:Color
    var subTitleColor:Color = .black
    
    // Optionally, we can create or own constructor
    // to initialise the view with some data / configurations
    init( colorOfTheTitle  c :Color){
        // some strange logic for initialisation
        titleColor = c
        if c == .red { subTitleColor = .blue }
    }
    
    var body: some View {
        VStack{
            Text("Data Binding").font(.largeTitle).foregroundColor(titleColor)
            Text("Overview").font(.footnote).padding(.bottom)
            
            GroupBox(label: Text("One Page")) {
                Text("How pass update data within current page.")
            }
            GroupBox(label: Text("Pass Data")) {
                Text("How to pass data between different views forth and back.")
            }
            GroupBox(label: Text("Observers")) {
                Text("How to design models where the data is updated by the users.")
            }
            Spacer()
            Text("Now tab the tabs below to go on...").foregroundColor(.gray)
        }
    }
}


struct ContentView: View {
    @State private var currTab = 1
    var body: some View {
        
        TabView(selection: $currTab) {
            OverviewView(colorOfTheTitle: .red)
                .tabItem { Text("Overview") }.tag(1)
            DataBindingOnePageView()
                .tabItem { Text("One Page") }.tag(2)
            DataBindingPassDataView()
                .tabItem { Text("Pass Data") }.tag(3)
            DataBindingObserveModelView()
                .tabItem { Text("Observers") }.tag(4)
            DataBindingObserveModelFromEnvironmentView()
                .tabItem { Text("Environment") }.tag(5)

            /*
            // find out the difference of
            // one instance PER View <= instance created WITHIN view
            DataBindingObserveModelView()
                .tabItem { Text("O2") }.tag(6)
            // one instance PER App <= instance INJECTED
            DataBindingObserveModelFromEnvironmentView()
                .tabItem { Text("E2") }.tag(7)
            */
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    // for tab 5 we need a different environment for preview
    // (compare the object created (WITHOUT demo data) and put into the environment in App.swift)
    
    // create SlideManagement WITH demo data
    static let slideMgmt = ObservableSlideModel( withInitialData: true)
    
    static var previews: some View {
        ContentView().environmentObject(slideMgmt)
    }
}
