//
//  AnimateOnTapView.swift
//  omd-ios-devel-chapter-09-Animation
//
//  Created by John on 02.02.23.
//

import SwiftUI

struct AnimateOnTapView: View {
    @State private var sizeInPercent = 0.7
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            Spacer()
            Text("2D Animation").padding().font(.title)
            Text("🥀")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .padding()
                .background(.green)
                .clipShape(Circle())
                .scaleEffect(sizeInPercent)
                .onTapGesture {
                    print("Tabbed, so we start animation with pulseValue of \(self.sizeInPercent)")
                    sizeInPercent += 0.3
                    if sizeInPercent > 2.2 {
                        sizeInPercent = 0.7
                    }
                }
                .animation(.easeInOut(duration: 3.0), value: sizeInPercent)
                .onReceive(timer) { _ in
                    guard sizeInPercent > 0.7 else {return}
                    sizeInPercent -= 0.1
                }
            Spacer()
            Text("Tap the flower a few times... ").padding()
        }.onAppear {
            sizeInPercent = 1.5
        }
        
    }
}

#Preview {
    AnimateOnTapView()
}
