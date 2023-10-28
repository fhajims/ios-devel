//
//  ListWithFilterView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Lists
//
//  Created by John on 31.08.23.
//

import SwiftUI

struct CustomMenu:View{
    @Binding var query:String
    
    var body: some View {
        Picker("Predefined Filters", selection: $query) {
            Text("Other").tag("Others")
            Text("Water").tag("Water")
            Text("Sun").tag("Sun")
            Text("Wind").tag("Wind")
            Text("All").tag("")
        }
    }
}



struct ListWithFilterView: View {
    
    @Environment(\.slideShowConfigShowIcons) var showIcons
    @EnvironmentObject var theSlideShowManagement:SlideshowManagement
    
    
    @State private var filterString = ""
    
    var query: Binding<String> {
        Binding {
            filterString
        } set: { newValue in
            if newValue == "-" {
                filterString = ""
                theSlideShowManagement.filter(by:nil)
            }else{
                filterString = newValue
                theSlideShowManagement.filter(by:filterString)
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                
                Label("Filter the List",
                      systemImage: "list.bullet.rectangle.fill")
                .padding(.top)
                .font(.title)
                
                if theSlideShowManagement.slides.count < 1 {
                    Text("Sorry, no slides for current filter.")
                        .multilineTextAlignment(.center)
                        .padding(.all)
                }
                
                List(theSlideShowManagement.slides) { slide in
                    NavigationLink(destination: SingleSlideView(slideID: slide.id)) {
                        VStack(alignment: .leading, spacing: 10){
                            HStack(){
                                if showIcons {
                                    Label("\(slide.title)", systemImage: slide.icon )
                                }else{
                                    Text("\(slide.title)")
                                }
                                Spacer()
                            }.padding(20)
                        }
                        .frame(width: 230, height: 48)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Filter Slides")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        CustomMenu(query: query)
                    }
                }
                Text(" \(theSlideShowManagement.slides.count) / \(theSlideShowManagement._slides.count)")
                Spacer()
                HStack{
                    Text("Type to filter:").foregroundColor(.accentColor)
                    TextField("Enter filter string...", text: $filterString)
                        .disableAutocorrection(true)
                        .foregroundColor(.secondary)
                }.padding(.all)
            }.onChange(of: filterString){
                theSlideShowManagement.filter(by: filterString)
            }
        }
    }
}

struct ListWithFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ListWithFilterView()
            .environmentObject(SlideshowManagement.shared)
            .environment(\.slideShowConfigShowIcons, true)
        ListWithFilterView()
            .environmentObject(SlideshowManagement.shared)
            .environment(\.slideShowConfigShowIcons, false)
        
    }
}

