//
//  SingleSlideView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Lists
//
//  Created by John on 18.01.22.
//

import SwiftUI

struct SingleSlideView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    
    var slideID:UUID
    @State private var slide:Slide? = nil
    
    var body: some View {
        ZStack{
            if let s:Slide = slide,
               let imgName:String = s.imageName {
                Image(imgName)
                    .resizable()
                    .scaledToFit()
                Text(s.title)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(colorScheme == .dark ? Color.gray : Color.black)
                    .padding([.top, .leading], 260.0)
                    .multilineTextAlignment(.center)
                    .shadow(radius: 4)
            }else{
                Text("Sorry, no image for slide with UUID of \(slideID). Try again")
                    .multilineTextAlignment(.center)
                    .padding(.all)
                    
            }
        }.onAppear(){
            slide = SlideshowManagement.shared.getSlideById(id: slideID)
        }
    }
}

struct SingleSlideView_Previews: PreviewProvider {
    

    static var previews: some View {
        let firstSlideOrNil = SlideshowManagement.shared.slides.first
        if let demoSlide = firstSlideOrNil {
            SingleSlideView(slideID:demoSlide.id)
            SingleSlideView(slideID:demoSlide.id).preferredColorScheme(.dark)
            if let lastSlideOrNil = SlideshowManagement.shared.slides.last{
                SingleSlideView(slideID:lastSlideOrNil.id)
            }
        } else {
            Text("Sorry, no slide available").preferredColorScheme(.dark)
                .multilineTextAlignment(.center)
                .padding(.all)
        }
    }
}
