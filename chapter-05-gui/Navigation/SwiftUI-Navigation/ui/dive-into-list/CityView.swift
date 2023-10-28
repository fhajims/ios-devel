//
//  CityView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Navigation
//
//  Created by John on 17.10.22.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let home = CLLocationCoordinate2D(latitude: 47.61582, longitude: 16.02452)
}
struct CityView: View {
    @State var city:City
    @State var currPos:Marker = Marker ("Home", coordinate:  .home)

    let zoomLevel=MKCoordinateSpan(
        latitudeDelta: 0.08,
        longitudeDelta: 0.08)
    var body: some View {
        VStack{
            Text("On our trip, we visit")
            Text(city.name)
            Map {
                currPos
                    .tint(.orange)
            }
            .mapControlVisibility(.visible)
            .mapStyle(.hybrid)
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
        }.onAppear(){
            currPos = Marker (city.name,coordinate: city.center)
        }
    }
}

// In the preview, we take a look at Kapfenberg
struct CityView_Previews: PreviewProvider {
    static let kbg = City(
        name:"Kapfenberg",
        locatedIn: stmk,
        center: .home
    )
    static var previews: some View {
        CityView(city:kbg)
    }
}
