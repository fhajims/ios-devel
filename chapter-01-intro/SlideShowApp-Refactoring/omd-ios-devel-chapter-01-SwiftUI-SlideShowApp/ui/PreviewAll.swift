//  PreView.swift

import SwiftUI

// Optimise .. put this struct into seperate file
struct SingleSlideView: View {
    var slideManager:SlideManager
    var slide:Slide
    @Binding var currSlide:Slide?
    @Binding var showFullscreen:Bool
    
    // Pulse on tap to give user "mini-feedback"
    @State private var isCurrentlyPulsing = false
    
    var body: some View {
        Image(slide.imgFileName ?? "sunset-10")
            .resizable()
            .aspectRatio(contentMode: showFullscreen ? .fill : .fit) //.scaledToFit()
            .padding()
            .onTapGesture(count: 2){
                print("Double-tap to toggle fullscreen on or off... ")
                showFullscreen.toggle()
            }
            .onTapGesture {
                currSlide = slideManager.slideAfter(slide: slide)
            }
            .gesture(DragGesture(minimumDistance: 21, coordinateSpace: .global)
                        .onEnded { value in
                let deltaX = value.translation.width as CGFloat
                let deltaY = value.translation.height as CGFloat
                
                if abs(deltaX) > abs(deltaY) {
                    print("Swipe \(deltaX < 0 ? "left" : "right") ")
                    // Optionally, improve by allow user to swipe forward and backward
                    currSlide = slideManager.slideAfter(slide: slide)
                } else {
                    print("Swipe \(deltaY < 0 ? "up" : "down") ")
                }
            })
            .overlay(
                GeometryReader(){ gr in
                    Image(systemName: slide.isFavorite ? "heart" : "heart.fill")
                        .frame( width: 40, height: 40,
                                alignment: .bottomLeading)
                        .offset(x: gr.size.width-40, y: 0)
                        .onTapGesture {
                            print("DEBUG: Set image \(slide.isFavorite ? "as" : "not as") my favorite.")
                            // for a moment we switch "pulsing" on, i.e. we start a mini animation
                            // for 0.1 seconds 3 times we activate (=animate) a scaleEffect (see below)
                            self.isCurrentlyPulsing = true
                            withAnimation(
                                .easeInOut(duration: 0.1)
                                    .repeatCount(3, autoreverses: true)) {
                                        currSlide = slideManager.toggleFavorite(slide)
                                        // after the small animation, we switch pulsing off again.
                                        // and the image is put back to original position (see scaleEffect)
                                        self.isCurrentlyPulsing = false
                                    }
                        }.scaleEffect(
                            // user feedback on tapping the heart image (to switch favorite on/off)
                            // when switched on, the icon moves (shakes) a bit to the left)
                            isCurrentlyPulsing ? 0.95: 1.0, anchor: .topTrailing)
                }
            )
        if showFullscreen{
            Button(action: {
                print("User wants to view full screen...")
                showFullscreen.toggle()
            }) {
                Image(systemName: showFullscreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right" ).imageScale(.large)
            }.padding()
        }else{
            Text(slide.title).font(.footnote)
        }
        
    }
}

struct PreviewAll: View {
    @EnvironmentObject var slideManager:SlideManager
    @State private var currSlide:Slide?=nil
    @Binding var showFullscreen:Bool
    var body: some View {
        VStack{
            if !showFullscreen {
                TextField(slideManager.slideshowTitle,
                          text: $slideManager.slideshowTitle)
                    .font(.title).multilineTextAlignment(.center)
                
            }
            if let slide:Slide = currSlide {
                
                
                SingleSlideView(slideManager: slideManager,
                                slide: slide,
                                currSlide: $currSlide, showFullscreen: $showFullscreen)
                
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
