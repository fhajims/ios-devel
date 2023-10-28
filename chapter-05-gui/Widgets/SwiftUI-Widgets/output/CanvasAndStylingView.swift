//
//  CanvasAndStylingView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Widgets
//
//  Created by John on 19.01.22.
//

import SwiftUI

struct CanvasAndStylingView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Ellipse()
                    .fill(.yellow)
                    .frame(width: geometry.size.width * 1.74, height: geometry.size.height * 0.3)
                    .position(x: geometry.size.width / 4.1, y: geometry.size.height * 0.1)
                    .shadow(radius: 5)
                    .edgesIgnoringSafeArea(.top)
                VStack{
                    
                    Text("Shapes & Canvas").font(.largeTitle)
                    
                    GroupBox(label: Text("Styling with boxes and circles")) {
                        HStack{
                            Circle().foregroundColor(.red)
                            Ellipse().strokeBorder()
                            Divider()
                            Rectangle().foregroundColor(.blue)
                            RoundedRectangle(cornerRadius: 9.4)
                        }
                        Text("Set forground color, stroke border and corner radius of given shapes such as circle, ellipse, rectangle (and dividers).").multilineTextAlignment(.center).font(.footnote)
                    }.frame(height: 180)
                    
                    
                    GroupBox(label: Text("Draw on a canvas")) {
                        HStack{
                            Canvas { context, size in
                                let newCenter = CGPoint(x: size.width/4, y: size.height/3)
                                let reducedSize = CGSize(
                                    width: size.width/2, height: size.height/3)
                                context.stroke(
                                    Path(ellipseIn: CGRect(origin: newCenter, size: reducedSize)),
                                    with: .color(.green),
                                    lineWidth: 9)
                                context.stroke(
                                    Path(ellipseIn: CGRect(origin: newCenter, size: reducedSize)),
                                    with: .color(.yellow),
                                    lineWidth: 4)
                            }
                            .frame(width: 130, height: 77)
                            //.border(Color.blue)
                        }
                        Text("Use context and size of canvas to draw your custom shapes.").multilineTextAlignment(.center).font(.footnote)
                    }.frame(height: 190)
                    
                }
                Spacer()
            }
        }
    }
}
struct CanvasAndStylingView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasAndStylingView()
        CanvasAndStylingView().preferredColorScheme(.dark)
    }
}
