//
//  OverlayBaseView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Navigation
//
//  Created by john on 19.01.22.
//

import SwiftUI

struct OverlayBaseView: View {
    
    
    
    
    @State var numberOfViews = 0
    
    
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                Image("sunset")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .padding()
                
                NavigationLink(destination: DetailsView(numberOfViews: $numberOfViews)) {
                    Text("Navigate to the details")
                    
                }
                Spacer()
                
                Text("View count: \(numberOfViews)")
            }.navigationTitle("Cancel")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct OverlayBaseView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayBaseView()
    }
}
