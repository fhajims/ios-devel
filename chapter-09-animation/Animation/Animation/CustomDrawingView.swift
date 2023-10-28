//
//  CustomDrawingView.swift
//  omd-ios-devel-chapter-09-Animation
//
//  Created by John on 02.02.23.
//

import SwiftUI

struct CustomDrawingView: View {
    @State var d = 25.0
    let timer = Timer.publish(every: 0.04, on: .main, in: .common).autoconnect()
    var body: some View {
        Path { path in
            let sizeInPxl: CGFloat = 80.0
            path.move(   to: CGPoint(x: sizeInPxl,    y: sizeInPxl) )
            path.addLine(to: CGPoint(x: sizeInPxl*2,  y: sizeInPxl*2) )
            path.addLine(to: CGPoint(x:  sizeInPxl*2, y:  sizeInPxl) )
        }
        .rotation(Angle(degrees: d))
        .rotationEffect(.degrees(d))
        .onReceive(timer) { _ in
                d += 3
        }
    }
}

#Preview {
        CustomDrawingView()
}
