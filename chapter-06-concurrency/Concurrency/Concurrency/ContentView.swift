//
//  ContentView.swift
//  omd-ios-devel-chapter-06-Concurrency
//



import SwiftUI




struct ContentView: View {
    @ObservedObject var manyHeroesViewModel:ViewModel
    @State
    private var currTab=2
    
    var body: some View {
        TabView(selection: $currTab) {
            SingleHeroView(currTab:$currTab)
                .tabItem { Text("A Hero") }.tag(1)
            ManyHeroes(viewModel: manyHeroesViewModel)
                .tabItem { Text("Many Heros") }.tag(2)
            Image("wikimedia-superheros")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .tabItem { Text("About") }.tag(3)
        }.task { // shorter than: .onAppear{ Task{ ...} }
            print("Info: Before this view appears... ")
            print("Info: ...concurrent code can be started here")
            // start some concurrent function/method/code
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let mockViewModel = ViewModel()
    static var previews: some View {
        ContentView(manyHeroesViewModel:mockViewModel)
    }
}
