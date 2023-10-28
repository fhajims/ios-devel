//
//  SlidesFromDBView.swift
//  omd-ios-devel-chapter-07-Persistency
//
//  Created by john on 16.02.22.
//

import SwiftUI

struct SlidesFromDBView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Photo.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Photo>
    
    
    var body: some View {
        VStack{
            
            Text("Persist to DB").font(.title)
            
            NavigationView {
                if items.isEmpty {
                    Text("Add data with the (+) button top right.")
                }
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            SingleSlideView(item: item)
                        } label: {
                            Text("\(item.title ?? "-title-not-set-")")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                Text("Select an item")
            }
        }
        
    }
    
    private func addItem() {
        let no = items.count // TODO: improve
        withAnimation {
            let newItem = Photo(context: viewContext)
            newItem.timestamp = Date()
            newItem.imageURL = "sunset-\(no+1)"
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct SlidesFromDBView_Previews: PreviewProvider {
    static var previews: some View {
        SlidesFromDBView().environment(\.managedObjectContext, PersistenceController.previewPhotos.container.viewContext)
    }
}
