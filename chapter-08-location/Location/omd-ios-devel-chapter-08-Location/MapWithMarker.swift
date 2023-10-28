//
//  MapWithMarker.swift
//  omd-ios-devel-chapter-08-Location
//
//  Created by john on 13.01.22.
//

import SwiftUI

import MapKit

struct AnnotatedItem: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    var tint: Color
}
// we start with a list of three Markers at fixed positions:
private var pointsOfInterest = [
    AnnotatedItem(name: "Kapfenberg", coordinate: .init(latitude: 47.45, longitude: 15.3), tint: .yellow),
    AnnotatedItem(name: "Graz", coordinate: .init(latitude: 47.07, longitude: 15.43), tint:.green),
    AnnotatedItem(name: "Gleichenberg", coordinate: .init(latitude: 46.87, longitude: 15.90), tint:.red)
]


extension CLLocationCoordinate2D {
    static let home = CLLocationCoordinate2D(
        latitude: 47.3,
        longitude: 15.5)
}

struct MapWithMarker: View {

    // List of markers displayed on the map
    @State var poiMapItems: [MKMapItem] = []

    
    var body: some View {
        VStack{
            Map() {
                Annotation("🛖",coordinate: .home){
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(.yellow).background()
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.secondary, lineWidth: 4 )
                        Label("My Home",systemImage: "house.fill").padding(3)
                    }
                }
                ForEach(pointsOfInterest) { poi in
                    Marker(
                        item: MKMapItem(
                            placemark: MKPlacemark(
                                coordinate: poi.coordinate))).tint(poi.tint).annotationTitles(.hidden)

                }
                // Show me on the map
                UserAnnotation()
            }
            .mapControlVisibility(.visible)
            .mapStyle(.hybrid(elevation: .flat))
            .safeAreaInset(edge: .bottom){
                    Label("My home? Search for it on the map... ",systemImage: "house.fill")
                        .padding(.all)
                        .foregroundColor(.accentColor)
            }
        }
    }

}

#Preview {
    MapWithMarker()
}
