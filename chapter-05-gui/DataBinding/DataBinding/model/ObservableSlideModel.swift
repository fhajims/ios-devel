//
//  ObserableSlideModel.swift
//  omd-ios-devel-chapter-05-SwiftUI-DataBinding
//
//  Created by John on 19.01.22.
//

import Foundation


class ObservableSlideModel:ObservableObject {
    @Published var slideShowTitle:String = "The Holiday Slideshow"
    @Published var slides = [Slide].self()
    
    let timer = Timer.publish(every: 1, on: .current, in: .common)
    
    private func calculateNextId() -> Int {
        let sortedSlidesById = self.slides.sorted {$0.id < $1.id }
        let highestSlide = sortedSlidesById.last
        var newID = 1
        if let s = highestSlide {
            newID = s.id + 1
        }
        return newID
    }
    public var nextId: Int {
        get {
            return calculateNextId()
        }
    }
    
    init(withInitialData:Bool = false){
        if withInitialData { addInitialData() }
        
        print("Just for fun, we add a new slide every 7th second :)")
        Timer.scheduledTimer(withTimeInterval: 7, repeats: true) { (t) in
            print(" \(Date()): Seven seconds are over.", terminator: "")
            
            let c = self.nextId
            Task { // we call an async function (marked with "await")
                await self.addAnotherSlideFromTimeToTime(c)
            }
        }
    }
    
    private func addInitialData(){
        // add dummy data
        self.slides.append(Slide(id: 1, title: "Sunset"))
        self.slides.append(Slide(id: 2, title: "Sunrise"))
        
    }
    
    // modifications to slides will be published to some UI
    // so better execute on main thread
    @MainActor
    private func addAnotherSlideFromTimeToTime(_ no:Int) async {
        print("We add new slide number '\(no)' now.")
        self.slides.append(Slide(id: no, title: "Sunrise-\(no)"))
    }
}
