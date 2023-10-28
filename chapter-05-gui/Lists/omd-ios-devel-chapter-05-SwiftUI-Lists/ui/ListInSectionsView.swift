//
//  ListInSectionsView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Lists
//
//  Created by John on 31.08.23.
//

import SwiftUI

struct ListInSectionsView: View {
    
    
    @Environment(\.slideShowConfigShowIcons) var showIcons
    
    @EnvironmentObject
    var theSlideShowManagement:SlideshowManagement
    
    var body: some View {
        
        NavigationView{
            VStack{
                
                Label("List with Sections",
                      systemImage: "list.bullet.below.rectangle")
                .padding(.top)
                .font(.largeTitle)
                
                List{
                    ForEach(Slide.Kind.allCases) { kind in
                        Section(header: Text(kind.rawValue)) {
                            ForEach(theSlideShowManagement.slidesByKind(kind)) { slide in
                                NavigationLink(destination: SingleSlideView(slideID: slide.id)) {
                                    Text("\(slide.title)")
                                    if showIcons{
                                        Image(systemName: slide.icon)
                                    }
                                }
                            }
                            
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Slides With Sections")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}


struct ListInSectionsView_Previews: PreviewProvider {
    static var previews: some View {
        ListInSectionsView()
            .environmentObject(SlideshowManagement.shared)
            .environment(\.slideShowConfigShowIcons, true)
        ListInSectionsView()
            .environmentObject(SlideshowManagement.shared)
            .environment(\.slideShowConfigShowIcons, false)
        ListInSectionsView()
            .environmentObject(SlideshowManagement.shared)
            .environment(\.slideShowConfigShowIcons, true)
            .preferredColorScheme(.dark)
    }
}
