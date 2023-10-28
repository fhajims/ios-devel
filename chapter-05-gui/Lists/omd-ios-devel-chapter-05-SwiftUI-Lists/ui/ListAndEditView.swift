//
//  ListAndEditView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Lists
//
//  Created by John on 31.08.23.
//

import SwiftUI

struct ListAndEditView: View {
    
    @Environment(\.slideShowConfigShowIcons) var showIcons
    
    
    @EnvironmentObject
    var theSlideShowManagement:SlideshowManagement
    
    var body: some View {
        NavigationView{
            VStack{
                
                Label("Edit the List",
                      systemImage: "list.bullet.clipboard.fill")
                .padding(.top)
                .font(.largeTitle)
                
                List(){
                    ForEach(
                        theSlideShowManagement.slides,
                        id: \.self
                    ) { slide in
                        NavigationLink(destination: SingleSlideView(slideID: slide.id)) {
                            if showIcons{
                                Label("\(slide.title)", systemImage: slide.icon )
                                .labelStyle(.titleAndIcon)
                            }else{
                                Label("\(slide.title)", systemImage: slide.icon )
                                .labelStyle(.titleOnly)
                            }
                        }
                    }
                    .onDelete { theSlideShowManagement.deleteSlide($0) }
                    .onMove { theSlideShowManagement.moveSlide(from: $0, to: $1) }
                    
                }.toolbar {
                    EditButton()
                }.refreshable {
                    // pull to refresh cache (i.e. reload data from web service)
                    print("TODO: add code to refresh data... ")
                }.listStyle(.plain)
                .navigationTitle("Edit List of Slides")
                .navigationBarTitleDisplayMode(.inline)
                
                Text("Use the 'Edit' button on the right top")
            }
        }
    }
}

struct ListAndEditView_Previews: PreviewProvider {
    static var previews: some View {
        ListAndEditView()
            .environmentObject(SlideshowManagement.shared)
            .environment(\.slideShowConfigShowIcons, true)
        ListAndEditView()
            .environmentObject(SlideshowManagement.shared)
            .environment(\.slideShowConfigShowIcons, false)
    }
}
