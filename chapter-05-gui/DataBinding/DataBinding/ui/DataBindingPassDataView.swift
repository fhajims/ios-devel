//
//  DataBindingPassDataView.swift
//  omd-ios-devel-chapter-05-SwiftUI-DataBinding
//
//  Created by John on 19.01.22.
//

import SwiftUI



struct DataBindingPassDataView: View {
    @State var mainTitle = ""
    @State var mainDesc = ""
    var body: some View {
        VStack{
            Text("Pass Data").font(.largeTitle).padding()
            GroupBox(label: Text("Main Level")) {
                HStack {Text("Title").bold();TextField("enter a title for the slide", text: $mainTitle)}
                HStack {Text("Description:").bold();TextField("enter a description ", text: $mainDesc)}
            }.background(.green)
            
            Text("We pass ref of descripion \(mainDesc) to nested views").font(.footnote).multilineTextAlignment(.center)
            Text("We copied the title to nested views once at creation.").font(.footnote).multilineTextAlignment(.center)
            NestedLevelOne(
                outerTitle: mainTitle, // pass a copy
                outerDescription: $mainDesc // pass a reference to allow "Binding"
            )
            
        }.foregroundColor(.black)
    }
}


struct NestedLevelOne:View{
    @State var outerTitle:String
    @Binding var outerDescription:String
    var body: some View {
        VStack{
            GroupBox(label: Text("First Level (outer nesting)")) {
                Text("We got a copy of the title and a reference to the desctiption from main view.").font(.footnote)
                HStack {Text("Title").bold();TextField("enter a title for the slide", text: $outerTitle)}
                HStack {Text("Description:").bold();TextField("enter a description ", text: $outerDescription)}
            }.background(.yellow)
            
            Text("Note, we copied the title of outer view to nested (inner) view once (on creation)").font(.footnote).multilineTextAlignment(.center)
            NestedLevelTwo(innerTitle: outerTitle, innerDescription: $outerDescription)
        }.foregroundColor(.blue)
    }
}
struct NestedLevelTwo:View{
    @State var innerTitle:String
    @Binding var innerDescription:String
    var body: some View {
        VStack{
            GroupBox(label: Text("Second Level (inner nesting)")) {
                Text("At creation time, we got (copied) values from outer view the title and a reference to the desctiption from outer view.").font(.footnote)
                HStack {Text("Title").bold();TextField("enter a title for the slide", text: $innerTitle)}
                HStack {Text("Description:").bold();TextField("enter a description ", text: $innerDescription)}
            }.background(.gray)
        }.foregroundColor(.red)
    }
}





struct DataBindingPassDataView_Previews: PreviewProvider {
    static var previews: some View {
        DataBindingPassDataView()
    }
}
