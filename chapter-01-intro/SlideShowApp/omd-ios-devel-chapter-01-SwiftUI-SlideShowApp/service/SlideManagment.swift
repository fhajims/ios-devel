//  SlideManagment.swift

import Foundation
class SlideManager :ObservableObject {
    @Published var slideshowTitle: String = "Last Slideshow" {
        didSet {
            print("TODO: Persist the changed slideshow title '\(slideshowTitle)'.")
        }
    }
    @Published var slides:[Slide] = []
    
    init(withInitialData:Bool = false){
        if withInitialData { seedWithDemoData() }
    }

    func slideAfter(slide:Slide) -> Slide? {
        guard var currIdx:Int = self.slides.firstIndex(of: slide) else {
            return self.slides.first
        }
        currIdx += 1
        return  currIdx < slides.count  ? slides[currIdx] : self.slides.first
    }
    
    private func seedWithDemoData(){
        self.slides.append(contentsOf: [
            Slide(title: "Sunset",
                  imgFileName: "sunset-10"),
            Slide(title: "At the beach",
                  imgFileName: "sunset-11"),
            Slide(title: "Water",
                  imgFileName: "sunset-12"),
            Slide(title: "Sand & Water",
                  imgFileName: "sunset-13"),
            Slide(title: "Fields",
                  imgFileName: "sunset-14"),
            Slide(title: "The see with a tree",
                  imgFileName: "sunset-15"),
            Slide(title: "A tree in the sun",
                  imgFileName: "sunset-16"),
            Slide(title: "Sky above the water",
                  imgFileName: "sunset-17")

        ])
    }
}

