
//
//  SlideManagement.swift
//  omd-ios-devel-chapter-05-UnitTesting
//
//  Created by John on 03.12.21.
//

import Foundation



class SlideManager {
    var slides:[Slide] = []
    var lastAddedID:Int? = nil
    var lastSlideAdded :Slide?  {
        get{
            slides.first( where: {$0.id == lastAddedID } )
        }
    }
    func add(_ newSlide: Slide){
        print("Adding slide \(newSlide)")
        lastAddedID = newSlide.id
        
        // fix this
        // it will break some test cases
        if !newSlide.title.isEmpty {
            slides.append(Slide(id: newSlide.id, title: newSlide.title + "!"))
        }else{
            slides.append(newSlide)
        }
        
    }
    func clear(){
        slides.removeAll()
    }
    private init(){
        print("*** INIT Slide Management (only ONCE) !")
        addInitialData()
    }
    static let sharedInstance = SlideManager()
    
    func update(slide s:Slide){
        guard let slideIdToUpdate = slides.firstIndex(where: {$0.id == s.id}) else{
            print("Error: Slide with id \(s.id) is not available in the pool of slides \(slides).")
            return
        }
        // update the title of the given slide
        slides[slideIdToUpdate].title = s.title
        print("We updated the slide title of \(s.id) to \(s.title) => \(slides)")
    }
    func addInitialData(){
        add( Slide(id: 1, title: "Sunset"))
        add( Slide(id: 2, title: "Sunrise"))
    }
}
