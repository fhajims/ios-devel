//
//  DataBindingObserveModelFromEnvironmentView.swift
//  omd-ios-devel-chapter-05-SwiftUI-DataBinding
//
//  Created by John on 21.01.22.
//

import SwiftUI

struct DataBindingObserveModelFromEnvironmentView: View {

    // we got injected an instance of an observalbe object
    // (from the environemnt)
    @EnvironmentObject var observalbeSlideModel:ObservableSlideModel
    
    @State private var newSlideTitle:String = ""
    
    // After inserting a new slide, we set the focus again into the input field
    // see the code below with ...focusedField = .addSlideTextField..
    private enum Field: Int, Hashable {
        case addSlideTextField, anyOtherView
    }
    @FocusState private var focusedField: Field?
    
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
            List($observalbeSlideModel.slides.reversed()) { slide in
                HStack {
                    Text("\(slide.id):")
                    TextField("Title: ", text: slide.title)
                }
            }
            Text("Feel free to add more slides").font(.caption2)
            TextField("Add: ", text: $newSlideTitle)
                .padding()
                .onSubmit {
                    let newID = observalbeSlideModel.nextId
                    observalbeSlideModel.slides.append(Slide(id: newID, title: newSlideTitle))
                    newSlideTitle = ""
                    focusedField = .addSlideTextField
                }.focused($focusedField, equals: .addSlideTextField)
        }.onAppear(){
            focusedField = .addSlideTextField
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

struct DataBindingObserveModelFromEnvironmentView_Previews: PreviewProvider {
    // create SlideManagement WITH demo data
    static let slideMgmt = ObservableSlideModel( withInitialData: true)
    
    static var previews: some View {
        DataBindingObserveModelFromEnvironmentView().environmentObject(slideMgmt)
    }
}
