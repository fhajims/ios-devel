//
//  SingleLineView.swift
//  omd-ios-devel-chapter-07-Persistency
//
//  Created by john on 16.02.22.
//

import SwiftUI

struct SingleSlideView: View {
    var item:Photo
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var newValue: String = ""
    
    var body: some View{
        VStack{
            Image(item.imageURL ?? "sunset-1")
                .padding(.horizontal, 30)
                .frame(width: 300, height: 200, alignment: .center)
                .mask(Rectangle().cornerRadius(40))
            HStack{
                Spacer()
                TextField("\(item.title ?? "-no-title-")", text: $newValue  ).onSubmit {
                    print("Save new title \($newValue) now")
                    item.title = "\(newValue)"
                    do {
                        try  viewContext.save()
                    }catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
                .frame(width: +160.0, height: 20.0)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10.0)
                Spacer()
            }
            Text("at \(item.timestamp ?? Date(), formatter: itemFormatter)")
            Text("Loaded from \(item.imageURL ?? "")")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


struct SingleSlideView_Previews: PreviewProvider {
    static let previewLineImage = Photo(context: PersistenceController.previewPhotos.container.viewContext)
    
    static var previews: some View {
        SingleSlideView(item: previewLineImage).environment(\.sizeCategory, .medium).environment(\.managedObjectContext, PersistenceController.previewPhotos.container.viewContext)
    }
}
