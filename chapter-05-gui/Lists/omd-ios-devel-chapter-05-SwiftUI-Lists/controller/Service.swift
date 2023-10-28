//
//  Service.swift
//  omd-ios-devel-chapter-05-SwiftUI-Lists
//
//  Created by john on 03.11.21.
//

import Foundation

class SlideshowManagement:ObservableObject {
    static let shared = SlideshowManagement()
    private init(){
        addAFewDemoSlides()
    }
    
    public private(set) var _slides: [Slide] = []

    
    // Note: current filter string is "Published",
    //       because we want to trigger updates on the UI
    @Published
    var currFilterString:String?=nil
    
    public var slides:[Slide] {
        guard let filterStr = self.currFilterString else{ return _slides}
        
        return _slides.filter {$0.title.contains( filterStr) }
    }
        
    private func addAFewDemoSlides() {
        _slides.append(contentsOf: [
            Slide(title: "Sunset", imageName: "sunset", kindOfSlide: .sun),
            Slide(title: "Sunrise", kindOfSlide: .sun),
            Slide(title: "Water", kindOfSlide: .water),
            Slide(title: "Sand", kindOfSlide: .other),
            Slide(title: "House", imageName: "house"),
            Slide(title: "Tree", imageName: "tree"),
        ])
    }
    func slidesByKind(_ filterType:Slide.Kind) -> [Slide] {
        return _slides.filter({ s in
            s.kindOfSlide == filterType
        })
    }
    func filter(by filterString:String?){
        self.currFilterString = (filterString != "") ? filterString : nil
    }

    func getSlideById(id:UUID) -> Slide?{
        return _slides.first(where: { $0.id == id })
    }
    
    // for edit button
    func deleteSlide(_ idxSet:IndexSet){
        _slides.remove(atOffsets: idxSet)

        // Trigger Publish changes (to other views)
        currFilterString=nil
    }
    func moveSlide(from idxSet:IndexSet, to pos_to:Int){
        _slides.move(fromOffsets: idxSet, toOffset: pos_to)

        // Trigger Publish changes (to other views)
        currFilterString=nil
    }
}
