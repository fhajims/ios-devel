//
//  ContentView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Accessibility
//
//  Created by John on 10.12.21.
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
                .accessibilityAddTraits(.isHeader)
                .accessibilityLabel("This it the Accessibility Demo named Lucky Number")
                .accessibilityValue("My Favorite Number")
            Text("Try Accessibility!")
                .foregroundColor(isEditing ? .red : .blue)
                .foregroundColor(Color.gray)
                .padding()
                .accessibilityHidden( true)
                .accessibilityShowsLargeContentViewer()
            Slider(value: $selection,
                   in: 2...9,
                   step:1)
                { Text("Slide-Selection")}
                onEditingChanged: { ed in
                    isEditing = ed
                }
                .padding(.leading)
                .padding(.trailing)
                .accessibilityLabel("My favorite number")
                .accessibilityHint("Select your favorite number by sliding to the left")
                // change specifier: speak "as integer", not "as float"
                .accessibilityValue("\(selection, specifier: "%1.1f" )")
                .accessibilityAddTraits(.allowsDirectInteraction)
                .accessibilityIdentifier("favNumberSlider")
                    // hidden
            Text( String(format: "%1.1f", selection ) )
                .accessibilityHidden( true)
            Spacer()
            
            Image("accessibility-hints+traits")
                .resizable()
                .padding(.horizontal)
                .scaledToFit()
            // is read after a short pause
                .accessibilityHint("A static image which we cannot modify")
            // is read immediately
                .accessibilityLabel("Screenshot of how to inspect the accessibility settings in the IDE")
                .accessibilityAddTraits( .isImage)
            // read after the label
                .accessibilityValue("editor-view-image.png")
                .aspectRatio(contentMode: .fit)
            Spacer()
            List {
                Picker("Flavor", selection: $selectedFlavor) {
                    Text("Chocolate").tag(Flavor.chocolate)
                    Text("Vanilla").tag(Flavor.vanilla)
                    Text("Strawberry").tag(Flavor.strawberry)
                }
            }
            .frame(height: 200.0)
            Text("Developers: please, preview sequence of elements, the labels, values, and traits in the Accessibility-Inspector!")
                .multilineTextAlignment(.center)
                .padding([.leading, .bottom, .trailing])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
    }
}
