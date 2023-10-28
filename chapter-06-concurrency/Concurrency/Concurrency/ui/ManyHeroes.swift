//
//  ManyHeroes.swift
//  omd-ios-devel-chapter-06-Concurrency
//
//  Created by john on 09.02.22.
//

import SwiftUI

let placeholder:UIImage = UIImage(named: "placeholder")!

// for many heros we extend the UIImage
//  added CREATE THUMBNAIL functionality
// Note: we use an ASYNC (!) property here
extension UIImage {
    var thumbnail: UIImage? {
        // TODO: will this be done several times ?
        //       do we need caching?
        get async {
            let thumbSize = CGSize(width: 135, height: 135)
            return await self.byPreparingThumbnail(ofSize: thumbSize)
        }
    }
}


struct ThumbnailView: View{
    @ObservedObject var viewModel: ViewModel
    var hero: Hero
    @State private var image: UIImage?
    var body: some View{
        Image(uiImage:  self.image ?? placeholder)
            .task {
                print(" * Async loading thumb for hero \(hero.name)... ")
                // short:
                // self.image = try? await self.viewModel.fetchThumbnail(for: hero.id)
                
                // long: = with all the details:
                guard let img =  try? await self.viewModel.fetchThumbnail(for: hero.id) else {
                    print("    xxx Sorry, no image available for hero \(hero.name).")
                    return
                }
                
                print("Hero \(hero.id) OK, image loaded, thumb created. Show on UI now!")
                self.image = img
            }
    }
}


struct ManyHeroes: View {
    @ObservedObject var viewModel: ViewModel
    
    
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            HStack{
                Spacer()
                Text("Heroes").font(.largeTitle)
                Spacer()
            }
            Spacer()
            ScrollView {
                ForEach(viewModel.heros){ hero in
                    HStack{
                        ThumbnailView(viewModel: viewModel, hero: hero)
                        Spacer()
                        Text("\(hero.name)").font(.title)
                    }.padding()
                }
            }
            Spacer()
            
            Group {
                
                Text("Reversed (to view heros added every 3s):").font(.subheadline).padding()
                ScrollView {
                    ForEach(viewModel.heros.reversed()){ hero in
                        HStack{
                            ThumbnailView(viewModel: viewModel, hero: hero)
                            Spacer()
                            Text("\(hero.name)")
                        }.padding()
                    }
                }
                
            }
            
        }
    }
    
    
}

struct ManyHeroes_Previews: PreviewProvider {
    static let mockViewModel = ViewModel(showDemoData:true)
    static var previews: some View {
        ManyHeroes(viewModel: mockViewModel)
    }
}
