//
//  ColorSliders.swift
//  omd-ios-devel-chapter-05-SwiftUI-Widgets
//
//  Created by John on 01.12.21.
//

import SwiftUI


struct ColorSliders: View {
    // use State variables to update UI dynamically
    @State var red: Double = 0.5
    @State var green: Double = 0.5
    @State var blue: Double = 0.5
    
    var body: some View {
        VStack{
            Text("Color Selection")
                .padding()
            Rectangle()
                .foregroundColor(Color(red: red, green: green, blue: blue))
            HStack {
                // hand over references
                // (instead of values)
                // to live-connect values
                // and update the values of this view
                ColorSlider(value: $red, textColor: .red)
                ColorSlider(value: $green, textColor: .green)
                ColorSlider(value: $blue, textColor: .blue)
            }

        }
    }
}



// Helper View
//
// Note the binding
// to update the color-values in the parent view

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    
    var body: some View {
        VStack {
            Slider(value: $value)
                .foregroundColor(textColor)
            Text("\(String(format: "%.2f", value))")
                .foregroundColor(textColor)
        }
        .padding()
    }
    
    
}



struct ColorSliders_Previews: PreviewProvider {
    static var previews: some View {
        ColorSliders()
        ColorSliders().preferredColorScheme(.dark)
    }
}
