//
//  SingleSlideView.swift
//  omd-ios-devel-chapter-01-SwiftUI-SlideShowApp
//
//  Created by John on 21.04.22.
//

import SwiftUI

struct SingleSlideView: View {
    var slideManager:SlideManager
    @State var currSlide:Slide
    @Binding var showFullscreen:Bool
    
    // Pulse on tap to give user "mini-feedback"
    @State private var isCurrentlyPulsing = false
    
    let placeholder = UIImage(systemName: "photo")!    // ! ...  we are we 100% sure the placeholder exists
    let loadingImg = UIImage(systemName: "timelapse")! // display loading image ... check out "SF Symbols"
    @State private var uiimg:UIImage?
    var body: some View {
        VStack{
            // We replace the static images with fetched images from the server
            // Image(slide.imgFileName ?? "sunset-10")
            Image.init(uiImage: uiimg ?? placeholder)
                .resizable()
                // How "onChange" – and a closure {...} with a capture list [...] – work:
                //   The new value is passed into the closure.
                //   The previous value may be captured by the closure to compare it to the new value.
                .onChange(of: currSlide) { [currSlide] nextSlide in
                    print("We switch from slide '\(currSlide.title)' " +
                          "to slide '\(nextSlide.title)', " +
                          "so we fetch the proper image from ws...")
                    uiimg = loadingImg
                    Task {
                        // display image fetched from the webservice (if available)
                        uiimg = try? await currSlide.uiImageFromCacheOrWebservice
                    }
                }
            //            .onAppear{
            //                Task {
            //                    uiimg = try? await currSlide.uiImageFromCacheOrWebservice
            //                }
            //            }
                .task {
                    print("The view appears, we fetch the first image from ws...")
                    uiimg = try? await currSlide.uiImageFromCacheOrWebservice
                }
                .aspectRatio(contentMode: showFullscreen ? .fill : .fit) //.scaledToFit()
                .padding()
                .onTapGesture(count: 2){
                    print("Double-tap to toggle fullscreen on or off... ")
                    showFullscreen.toggle()
                }
                .onTapGesture {
                    currSlide = slideManager.slideAfter(slide: currSlide) ?? currSlide
                }
                .gesture(DragGesture(minimumDistance: 21, coordinateSpace: .global)
                    .onEnded { value in
                        let deltaX = value.translation.width as CGFloat
                        let deltaY = value.translation.height as CGFloat
                        
                        if abs(deltaX) > abs(deltaY) {
                            print("Swipe \(deltaX < 0 ? "left" : "right") ")
                            // Optionally, improve by allow user to swipe forward and backward
                            currSlide = slideManager.slideAfter(slide: currSlide) ?? currSlide
                        } else {
                            print("Swipe \(deltaY < 0 ? "up" : "down") ")
                        }
                    })
                .overlay(
                    GeometryReader(){ gr in
                        Image(systemName: currSlide.isFavorite ? "heart" : "heart.fill")
                            .frame( width: 40, height: 40,
                                    alignment: .bottomLeading)
                            .offset(x: gr.size.width-40, y: 0)
                            .onTapGesture {
                                print("DEBUG: Set image \(currSlide.isFavorite ? "as" : "not as") my favorite.")
                                // for a moment we switch "pulsing" on, i.e. we start a mini animation
                                // for 0.1 seconds 3 times we activate (=animate) a scaleEffect (see below)
                                self.isCurrentlyPulsing = true
                                withAnimation(
                                    .easeInOut(duration: 0.1)
                                    .repeatCount(3, autoreverses: true)) {
                                        currSlide = slideManager.toggleFavorite(currSlide)
                                        // after the small animation, we switch pulsing off again.
                                        // and the image is put back to original position (see scaleEffect)
                                        self.isCurrentlyPulsing = false
                                    }
                            }.scaleEffect(
                                // user feedback on tapping the heart image (to switch favorite on/off)
                                // when switched on, the icon moves (shakes) a bit to the left)
                                isCurrentlyPulsing ? 0.95: 1.0, anchor: .topTrailing)
                    }
                ).animation(.easeInOut(duration: 0.25), value: uiimg )
                .opacity( uiimg == loadingImg ? 0.2 : 1.0 )
            if showFullscreen{
                Button(action: {
                    print("User wants to view full screen...")
                    showFullscreen.toggle()
                }) {
                    Image(systemName: showFullscreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right" ).imageScale(.large)
                }.padding()
            }else{
                Text(currSlide.title).font(.footnote)
            }
            
        }
        
    }
}



struct SingleSlideView_Previews: PreviewProvider {
    
    // prepare some demo data for Xcode preview:
    static let previewSlideMgr = SlideManager( withInitialData: true)
    static let slide13 = Slide(
        title: "Sunset",
        imgFileName: "Sunset-13"
    )
    @State static var showFSfalse = true
    static var previews: some View {
        
        SingleSlideView(slideManager: previewSlideMgr,
                        currSlide: slide13,
                        showFullscreen: $showFSfalse)
        .environmentObject(previewSlideMgr)
    }
}
