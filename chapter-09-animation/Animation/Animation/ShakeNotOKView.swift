//
//  ShakeNotOKView.swift
//  omd-ios-devel-chapter-09-Animation
//
//  Created by John on 02.02.23.
//

import SwiftUI

// see the Apple tutorial "Animating Views and Transitions"
// https://developer.apple.com/tutorials/swiftui/animating-views-and-transitions


struct ShakeNotOKView: View {

    @State
    var thumbsUp:Bool=false
    
    @State
    var startTheAnimation:Bool=false
    
    var body: some View {
        VStack{
            Spacer()
            
            Text("Animation").font(.title).padding(.all)
            Button(action: {
                withAnimation (.easeInOut(duration: 3)) {
                    thumbsUp.toggle()
                }
                
            }, label: {
                Label("Up/down", systemImage: "arrow.up.and.down.and.sparkles")
            })
            Spacer()
            if thumbsUp {
                // hide ok with "minimise" effect
                Text("OK").font(.largeTitle)
                    .transition(.scale(scale: 0.1))
            }
            Spacer()
            HStack{
                Text(" 👎 ")
                    .rotationEffect(.degrees(thumbsUp ? 180 : 0))
                    .scaleEffect(thumbsUp ? 2.1 : 1)
                Button(action: shake){
                    Text("Shake means 'not ok'")
                }
            }
            .offset(x: startTheAnimation ? 10.0 : -10.0)
            .animation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 1.2), value: startTheAnimation)
            Spacer()
        }
    }
    
    func shake(){
        startTheAnimation.toggle()
    }
}

#Preview {
    ShakeNotOKView()
}
