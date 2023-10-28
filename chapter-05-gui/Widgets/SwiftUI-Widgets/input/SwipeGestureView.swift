//
//  SwipeGestureView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Widgets
//
//  Created by John on 24.01.23.
//

import SwiftUI

struct SwipeGestureView: View {
    @State
    private var currDirection:Directions? = nil
    var body: some View {
        VStack{
            Text("Swipe Gestures")
            Text("Now swipe on this text")
                .fontWeight(.heavy)
                .foregroundColor(Color.green)
                .multilineTextAlignment(.center)
                .padding(.vertical)
                .frame(width: 330.0, height: 140.0)
                .swipe{ direction in
                    print("Swiping \(direction) on the text box")
                    currDirection = direction
                }
             Text("Lately, you swiped \(currDirection?.rawValue ?? "...")")
        }
    }
}
// We extend every(!) view (e.g. Text, Button,...)
// to provide a "swipe" feature
enum Directions: String {
    case up = "up", down = "down", left = "left", right = "right"
}
extension View {
    func swipe(
        action: @escaping ((Directions) -> Void)
    ) -> some View {
        return self.gesture(DragGesture(minimumDistance: 2.0, coordinateSpace: .local)
            .onEnded({ value in
                switch(value.translation.width, value.translation.height) {
                case (...0, -35...35):  action(.left)
                case (0..., -35...35):  action(.right)
                case (-80...80, ...0):  action(.up)
                case (-80...80, 0...):  action(.down)
                default:  print("Ignoring, gesture not recognised")
                }
            }))
    }
}

struct SwipeGestureView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeGestureView()
    }
}
