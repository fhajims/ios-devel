//
//  DataBindingObserveModelView.swift
//  omd-ios-devel-chapter-05-SwiftUI-DataBinding
//
//  Created by John on 19.01.22.
//

import SwiftUI

struct DataBindingObserveModelView: View {
    
    // only ONE object is created for this view
    // will not be recreated at initialisation of this view
    @ObservedObject var observalbeSlideModel = ObservableSlideModel()
    
    @State private var newSlideTitle:String = ""
    var body: some View {
        VStack{
            Text("Observers").font(.title).padding()
            
            Image("sunset").resizable().scaledToFit()
            TextField(
                "Edit the title:",
                text: $observalbeSlideModel.slideShowTitle)
                .padding()
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
            List($observalbeSlideModel.slides.reversed() ) { slide in
                HStack {
                    Text("\(slide.id):")
                    TextField("Title: ", text: slide.title)
                }
            }
            Text("Feel free to add more slides").font(.caption2)
            TextField("Add: ", text: $newSlideTitle)
                .padding()
                .onSubmit {
//                    let sortedSlidesById = $observalbeSlideModel.slides.sorted {$0.id < $1.id }
//                    let highestSlide = sortedSlidesById.last
//                    var newID = 1
//                    if let s = highestSlide {
//                        newID = s.id + 1
//                    }
                    let newID = observalbeSlideModel.nextId
                    observalbeSlideModel.slides.append(Slide(id: newID, title: newSlideTitle))
                    newSlideTitle = ""
                }
        }
        // Optionally, we might react on changes in the background service (changes in the "Publisher")
        .onReceive(observalbeSlideModel.$slides){ slds in
            print("DEBUG: Just for your info: slides \(slds) have changed...")
        }
        .onReceive(observalbeSlideModel.$slideShowTitle){ title in
            print("DEBUG: Just for your info: title \(title) has changed...")
        }
    }
}

struct DataBindingObserveModelView_Previews: PreviewProvider {
    static var previews: some View {
        DataBindingObserveModelView()
    }
}
