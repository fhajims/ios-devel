//
//  DataBindingOnePageView.swift
//  omd-ios-devel-chapter-05-SwiftUI-DataBinding
//
//  Created by John on 19.01.22.
//

import SwiftUI

struct DataBindingOnePageView: View {
    
    // init with dummy slide
    @State private var slide:Slide = Slide(id: 0, title: "dummy")
    
    // fetch data once from the data management (see "onAppear" below)
    var dataMgmt = SlideManager.sharedInstance
    
    // switch between static title and editable title
    @State private var editMode:Bool = false
    
    //@State private var editColor:Color = .red
    
    // when switching on the edit mode, we focus the edit title field
    @FocusState private var editTitleFieldIsFocused:Bool
    
    var body: some View {
        VStack{
            Text("Update state").font(.title)
            if slide.id == 0 {
                Text("Sorry, no slide available.")
            }else{
                Image("sunset").resizable().scaledToFit()
                if editMode {
                    TextField(
                        "Edit the title:",
                        text: $slide.title)
                        .padding()
                        .focused($editTitleFieldIsFocused)
                        .onSubmit {
                            print("We are updating the title of slide \(slide.id) via slide managment.")
                            dataMgmt.update(slide:slide)
                            // Note: check out observalble objects, which would updates easier
                            
                        }
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .border(.secondary)
                        .foregroundColor(editTitleFieldIsFocused ? .red : .blue)
                    if editTitleFieldIsFocused {
                        Text("Store/submit by pressing RETURN").font(.footnote)
                    }
                }else{
                    Text("\(slide.title)").foregroundColor(.blue)
                }
                
                // If edit mode is switched on, we present the edit text field from above
                Toggle(isOn: $editMode) {
                    Text("Edit mode: \(editMode ? "on" : "off")").padding(.horizontal)
                }.onSubmit(){
                    // put the focus into the edit text field
                    editTitleFieldIsFocused.toggle()
                }
            }
        }.onAppear(){
            // get slide from service
            print("On Appear, we get a slide from the manager. Available slides: \(dataMgmt.slides)")
            if let s = dataMgmt.lastSlideAdded {
                slide = s
                print("We select to show the last slide: \(slide)")
            }
        }
    }
}

struct DataBindingOnePageView_Previews: PreviewProvider {
    static var previews: some View {
        DataBindingOnePageView()
    }
}
