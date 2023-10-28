//
//  FollowMeMapView.swift
//  omd-ios-devel-chapter-08-Location
//
//  Created by john on 13.01.22.
//

import SwiftUI


import MapKit
import CoreLocation


struct FollowMeMapView: View {

    // A camera position that follows th user's location
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)

    var body: some View {
        VStack{
            Text("In Simulator activate\nFeatures/Location/Freeway Drive")
                .multilineTextAlignment(.center)
                .padding()
            Map(position: $position)
        }
    }
}

#Preview {
    FollowMeMapView()
}

/* To find out more Map-related features, check out:
    https://developer.apple.com/videos/play/wwdc2023/10043/
 */
