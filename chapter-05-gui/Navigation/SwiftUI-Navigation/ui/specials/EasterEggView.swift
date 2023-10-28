//
//  MainSpecialView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Navigation
//
//  Created by John on 24.01.23.
//

import SwiftUI


// a view ("hidden") at startup
// see App.swift
struct TheHiddenEasterEggView: View {
    
    @Binding var showHiddenSpecialsViews:Bool
    
    @State private var selected = 0
    fileprivate func dynTab(title:String) -> VStack<TupleView<(some View, some View, some View,some View)>> {
        return VStack{
            Text("iOS Navigation Specials")
                .font(.title)
                .padding(.bottom)
            Text("\(title)")
                .font(.title)
                .padding(.bottom)
            Text("Surprise, this simple hidden screen was the Easter Egg.").multilineTextAlignment(.center).padding(.horizontal)
            Button("Hide the Easter Egg screen"){
                showHiddenSpecialsViews=false
            }.padding(.all)
        }
    }
    
    var body: some View {
        TabView() {
            // nice for up to 5 entries
            ForEach(1..<11) {
                dynTab(title: "Nr.\($0)")
            }
        }
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .tabViewStyle(.page)
    }
}

struct TheHiddenEasterEggView_Previews: PreviewProvider {
    @State
    static var showHidden = false
    
    static var previews: some View {
        TheHiddenEasterEggView(showHiddenSpecialsViews: $showHidden)
    }
}
