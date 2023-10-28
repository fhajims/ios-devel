//
//  ContentView.swift
//  omd-ios-devel-chapter-08-Location
//
//  Created by john on 13.01.22.
//

import SwiftUI

// User Location on map: "...The map displays the location only if the user has authorized the app to access their location..."
// Info.plist
// Privacy - Location When In Use Usage Description
// e.g. set string to "Watch your movements, allow to show your current location"


import MapKit

struct ContentView: View {

    @State var homeRegion = MKCoordinateRegion(
        center:  CLLocationCoordinate2D(
            latitude: 47.43,
            longitude: 15.3
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5
        )
    )

    @State private var currTab = 2

    var body: some View {
        VStack{
            Text("Location and Maps").font(.title).padding()
            TabView(selection: $currTab) {

                MapWithMarker()
                    .tabItem {
                        Label("Markers", systemImage: "mappin" )
                    }.tag(1)

                Map {
                    Marker("Home", coordinate: homeRegion.center)
                }
                .tabItem {
                    Label("Map", systemImage: "map")
                }.tag(2)

                FollowMeMapView().tabItem {
                    Label ("Follow me", systemImage: "location")
                }.tag(3)

            }.padding(.bottom)
        }
    }
}

#Preview {
    ContentView()
}
