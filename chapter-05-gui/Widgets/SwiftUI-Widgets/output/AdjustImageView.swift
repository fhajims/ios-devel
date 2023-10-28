//
//  AdjustImageView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Widgets
//
//  Created by John on 18.01.22.
//

import SwiftUI

struct AdjustImageView: View {
    @State private var imageShouldFit = true
    
    @State private var showDetails: Bool = false
    @State private var scale = 1.0
    var body: some View {
        VStack{
            Text("Foto Book Image")
                .font(.title3)
            Image("sunset")
                .resizable()
                .aspectRatio(contentMode: imageShouldFit ? .fit : .fill)
                // Optionally, set fixed size:
                //.frame(width: , height: 150, alignment: .center)
                .padding()
                .scaleEffect(scale)
                .clipShape( RoundedRectangle(cornerRadius: 67.0) )
                .shadow(radius: 13)
                // Optionally, "mask" the image to a circle
                // .clipShape( Circle() )
                // .overlay (Circle().stroke (Color.yellow, lineWidth: 3))
                .padding(.horizontal).frame(minWidth: 120)
            DisclosureGroup("Adjust the image",isExpanded: $showDetails) {
                Toggle(isOn: $imageShouldFit) {
                    Text("Fit or fill: \( imageShouldFit ? "Fit" : "Fill" )")
                }
                Slider(value: $scale)
            }.padding()
        }
        
    }
}


struct AdjustImageView_Previews: PreviewProvider {
    static var previews: some View {
        AdjustImageView()
        AdjustImageView().preferredColorScheme(.dark)
    }
}

