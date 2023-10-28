//
//  Persistence.swift
//  omd-ios-devel-chapter-07-Persistency
//
//  Created by John on 03.11.21.
//

import CoreData

fileprivate func addDummyData(_ viewContext: NSManagedObjectContext) {
    for no in 1..<10 {
        let newPhoto = Photo(context: viewContext)
        newPhoto.viewCount = 0
        newPhoto.imageURL = "sunset-\(no)"// "https://my.server.com/api/photo/\(no)"
        newPhoto.title = "Photo-\(no)"
        newPhoto.timestamp = Date()
        newPhoto.notes = "Another demo photo added"
    }
    do{
        try viewContext.save()
    }catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
}

struct PersistenceController {
    static let shared = PersistenceController()

    
    // for Persistency 07:
    
    static var previewPhotos: PersistenceController = {
        let res = PersistenceController(inMemory: true)

        addDummyData(res.container.viewContext)
        
        return res
        
    }()
    

    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "omd_ios_devel_chapter_07_Persistency")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
