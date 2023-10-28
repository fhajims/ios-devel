//
//  OverlaySheetView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Navigation
//
//  Created by john on 19.01.22.
//

import SwiftUI

struct OverlaySheetView: View {
    
    @State private var editMode:Bool = false
    @State var numberOfViews = 0
    
    var body: some View {
        VStack{
            Spacer()
            Image("sunset")
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
                .padding()
                .onTapGesture {
                    editMode.toggle()
                }
        
            .sheet(isPresented: $editMode){
                DetailsView(numberOfViews: $numberOfViews)
            }
            Toggle(isOn: $editMode) {
                Text("Show overlay the \(numberOfViews) time with some details").padding()
            }
            Spacer()
        }
    }
}

struct OverlaySheetView_Previews: PreviewProvider {
    static var previews: some View {
        OverlaySheetView()
    }
}
