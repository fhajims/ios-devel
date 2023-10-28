//  PreView.swift

import SwiftUI

struct PreviewAll: View {
    
    @EnvironmentObject var slideManager:SlideManager
    
    @State private var currSlide:Slide?=nil
    
    var body: some View {
        VStack{
            
            TextField(slideManager.slideshowTitle,
                      text: $slideManager.slideshowTitle)
                .font(.title).multilineTextAlignment(.center)
            
            if let slide:Slide = currSlide {
                Image(slide.imgFileName ?? "sunset-10").resizable()
                    .scaledToFit()
                    .padding()
                    .onTapGesture {
                        currSlide = slideManager.slideAfter(slide: slide)
                    }
                Text(slide.title).font(.footnote)
            }else{
                Text("Add slides in the management tab")
                    .padding()
            }
        }.onAppear(){
            currSlide = slideManager.slides.first
        }
    }
}

struct PreviewAll_Previews: PreviewProvider {
    
    static let previewSlideMgr = SlideManager( withInitialData: true)
    
    static var previews: some View {
        PreviewAll()
            .environmentObject(previewSlideMgr)
        PreviewAll()
            .environmentObject(previewSlideMgr)
            .preferredColorScheme(.dark)
    }
}
