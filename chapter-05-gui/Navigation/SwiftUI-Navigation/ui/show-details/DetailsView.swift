//
//  DetailsView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Navigation
//
//  Created by john on 03.11.21.
//

import SwiftUI

struct DetailsView: View {
    // Optionally, dismiss on button click
    @Environment(\.dismiss) var dismiss
    
    @Binding var numberOfViews:Int
    
    var body: some View {
        VStack{
            Spacer()
            Text("The Image Details")
            Spacer()
            Image("sunset")
            Spacer()
            Button("OK, I confirm, that I've seen the image!"){
                numberOfViews += 1
                dismiss()
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    @State static var no:Int=7
    static var previews: some View {
        DetailsView(numberOfViews: $no)
    }
}
