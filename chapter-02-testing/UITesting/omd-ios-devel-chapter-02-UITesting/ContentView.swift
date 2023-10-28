//
//  ContentView.swift
//  omd-ios-devel-chapter-02-UITesting
//
//  Created by John on 31.01.23.
//

import SwiftUI

struct ContentView: View {
    // The picker example from Xcode
    enum Flavor: String, CaseIterable, Identifiable {
        case chocolate, vanilla, strawberry
        var id: Self { self }
    }
    @State private var selectedFlavor: Flavor = .chocolate
    
    @State private var selection = 3.0
    @State private var isEditing = false
    @State private var formattedSelection = ""
    var body: some View {
        VStack {
            Spacer()
            Text("Lucky Number")
                .font(.largeTitle)
                .padding(.top)
                .accessibilityIdentifier("theTitle")
            Slider(value: $selection,
                   in: 2...9,
                   step:1)
            { Text("Slide-Selection")}
        onEditingChanged: { ed in
            isEditing = ed
        }
        .padding(.leading)
        .padding(.trailing)
        .accessibilityIdentifier("favNumberSlider")
            Text( String(format: "%1.1f", selection ) )
                .accessibilityHidden( true)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
