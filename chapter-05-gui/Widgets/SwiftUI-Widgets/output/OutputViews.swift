//
//  OutputViews.swift
//  omd-ios-devel-chapter-05-SwiftUI-Widgets
//
//  Created by John on 17.01.22.
//

import SwiftUI


struct DemoImage: View{
    var body: some View{
        VStack{
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 4).frame(width: 200, height: 200)
                )
                .shadow(radius: 10)
                .padding(.top, 50)
            Text("In the code replace dummy system image 'person' with your profile image.")
                .padding(.all, 80)
                .multilineTextAlignment(.center)
                .foregroundColor(.blue)
            
        }
    }
}

struct DemoChars: View{
    var body: some View{
        HStack(spacing: 10){
            Text("UTF-8:")
                .font(.callout)
            VStack{
                ScrollView(.vertical, showsIndicators: true) {
                    HStack{Text("Cards");Text("🂱 🂸 🂱 🃗 🃓").font(.largeTitle)}
                    HStack{Text("Chess");Text(" ♕ ♘ ♤").font(.largeTitle)}
                    Text("Scroll to find many more").padding(.bottom)
                    Text("Such as ☯︎ ✎ © ")
                    Text("Even more 🇹🇯 🔨 ⚓️ ")
                    Text("Many more 🌩🚰 🎵 ")
                    Text("Much more  ➰ 🔘 ۺ")
                }.frame(height: 100)
            }
        }.tint(.accentColor)
            .frame(maxWidth: .infinity)
    }
}


struct DemoFonts: View{
    var body: some View{
        HStack(spacing: 10){
            Text("Font:")
                .font(.callout)
            VStack{
                Text(".lageTitle")
                    .font(.largeTitle)
                Text(".title")
                    .font(.title)
                Text(".footnote")
                    .font(.footnote)
            }
        }.tint(.accentColor)
            .frame(maxWidth: .infinity)
    }
}
struct DemoPadding: View{
    var body: some View{
        HStack(spacing: 10){
            Text("Padding:")
                .font(.callout)
            VStack{
                Text(".leading")
                    .padding(.leading)
                    .font(.footnote)
                    .background(.secondary)
                    .frame(minHeight: 25)
                Text(".trailing")
                    .padding(.trailing)
                    .font(.footnote)
                    .background(.secondary)
                    .frame(minHeight: 25)
                Text(".horizontal")
                    .padding(.horizontal)
                    .font(.footnote)
                    .background(.secondary)
                Text(".vertical")
                    .padding(.vertical)
                    .font(.footnote)
                    .background(.secondary)
                    .frame(minHeight: 55)
            }.background(.gray)
        }.frame(maxWidth: .infinity)
    }
}

struct SFSymbolsURL: View {
    let url = "https://developer.apple.com/sf-symbols/"
    var body: some View{
        Button(action: {
            guard let url = URL(string: url) else { return }
            UIApplication.shared.open(url)
        }) {
            Text("First, download SF-Symbols 3 from Apple")
        }
    }
}
struct DemoSymbols: View{
    var body: some View{
        VStack{
            SFSymbolsURL().padding()
            Text("Then, lookup name in App.")
            Text("e.g. 'cart.circle':")
            HStack{
                Image(systemName: "cart.circle")
                Image(systemName: "cart.circle")
                    .background()
                Image(systemName: "cart.circle")
                    .foregroundColor(.red)
                Image(systemName: "cart.circle")
                    .shadow(radius: 0.3)
                Image(systemName: "cart.circle")
                    .colorInvert()
            }
            
        }.tint(.accentColor)
            .frame(maxWidth: .infinity)
    }
}





struct OutputViews: View {
    
    @State private var respectSafeArea:Bool = false
    @State private var selectedTab:Int = 2
    var body: some View {
        VStack{
            Text("Texts & Images")
                .font(.largeTitle)
                .padding()
            TabView(selection: $selectedTab) {
                VStack{
                    DemoChars()
                    DemoFonts()
                    DemoPadding()
                }   .tabItem {Text("Texts")       }.tag(1)
                DemoImage()
                    .tabItem {Text("Clip-Image")  }.tag(2)
                AdjustImageView()
                    .tabItem {Text("Adjust-Image")}.tag(3)
                DemoSymbols()
                    .tabItem {Text("Symbols")     }.tag(4)
            }
            Spacer()
        }
    }
}

struct OutputViews_Previews: PreviewProvider {
    static var previews: some View {
        OutputViews()
        OutputViews().preferredColorScheme(.dark)
    }
}
