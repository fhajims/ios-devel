//
//  ContentView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Widgets
//
//  Created by John on 01.12.21.
//

import SwiftUI


struct ContentView: View {
    
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Built-in Views").font(.largeTitle)
                GroupBox(label:
                            Label("Output", systemImage: "building.columns")
                ) {
                    HStack{
                        Text("Simple")
                        NavigationLink(destination:OutputViews() ){
                            Text("Text, symbols, and images")
                                .multilineTextAlignment(.leading)
                                .lineLimit(7)
                                .padding()
                                .frame(minHeight: 80)
                        }
                        Text("&")
                        NavigationLink(destination:CanvasAndStylingView() ){
                            Text("Styling, Canvas")
                                .multilineTextAlignment(.leading)
                                .lineLimit(7)
                                .padding()
                                .frame(minHeight: 80)
                        }
                    }
                }
                
                GroupBox(label:
                            Label("Input", systemImage: "building")
                ) {
                    HStack{
                        Text("Simple")
                        NavigationLink(destination:SomeInputView() ){
                            Text("Textfields, progress, stepper, button, toggle")
                                .multilineTextAlignment(.leading)
                                .lineLimit(7)
                                .padding()
                                .frame(minHeight: 122)
                        }
                        
                        Text("&")
                        VStack{
                            Spacer()
                            NavigationLink(destination:ComplexInputsView() ){
                                Text("Forms, Pickers")
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                    .padding()
                            }
                            NavigationLink(destination:SwipeGestureView()){
                                Text("Swipe")
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3)
                                    .padding()
                            }
                            Spacer()
                        }
                        
                    }
                    
                }
                GroupBox(label:
                            Label("Input/Output", systemImage: "building.2")
                ) {
                    HStack{
                        Text("Colors")
                        NavigationLink(destination:ColorSliders() ){
                            Text("Adjust with Sliders")
                                .padding()
                        }
                    }
                }
                
                //                GroupBox(label:
                //                            Label("Layout", systemImage: "display")
                //                ) {
                //                    HStack{
                //
                //                        Text("Save Area")
                //                        NavigationLink(destination:SafeAreaViews() ){
                //                            Text("Present in fullscreen")
                //                                .padding()
                //                        }
                //                    }
                //
                //                }
                
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // better preview your UI in light
        ContentView()
        // and dark mode at the same time
        ContentView().preferredColorScheme(.dark)
    }
}




