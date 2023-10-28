//  PreView.swift

import SwiftUI


struct PreviewAll: View {
    @EnvironmentObject var slideManager:SlideManager
    @Binding var showFullscreen:Bool
    @State var currSlide:Slide?
    var body: some View {
        VStack{
            if !showFullscreen {
                TextField(slideManager.slideshowTitle,
                          text: $slideManager.slideshowTitle)
                    .font(.title).multilineTextAlignment(.center)
                
            }
            if let slide:Slide = currSlide {
                
                
                SingleSlideView(slideManager: slideManager,
                                currSlide: slide,
                                showFullscreen: $showFullscreen)
                
                //                // START extract to another struct
                //                Image(slide.imgFileName ?? "sunset-10").resizable()
                //                    .scaledToFit()
                //                    .padding()
                //                    .onTapGesture {
                //                        currSlide = slideManager.slideAfter(slide: slide)
                //                    }
                //                Text(slide.title).font(.footnote)
                //                // END extract to another struct
                
            }else{
                Text("To get images, please check if the WebService is running! Possibly, you need to start a local server by running the script './server.sh'.")
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }.onAppear(){
            currSlide = slideManager.slides.first
        }
    }
    
}

struct PreviewAll_Previews: PreviewProvider {
    
    static let previewSlideMgr = SlideManager( withInitialData: true)
    @State static var showFS = false
    @State static var showFStrue = true
    static var previews: some View {
        
        PreviewAll(showFullscreen: $showFS)     // bright and no fullscreen
            .environmentObject(previewSlideMgr)
        PreviewAll(showFullscreen: $showFStrue) // dark mode and fullscreen
            .environmentObject(previewSlideMgr)
            .preferredColorScheme(.dark)
    }
}
