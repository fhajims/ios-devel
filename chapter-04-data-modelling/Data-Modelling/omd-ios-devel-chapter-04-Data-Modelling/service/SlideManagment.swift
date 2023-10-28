//
//  SlideManagment.swift
//  omd-ios-devel-chapter-04-Data-Modelling
//
//  Created by John on 06.03.23.
//

import Foundation
class SlideManager{
        var slides:[Slide] = []
        
        init(withInitialData:Bool = false){
            if withInitialData {
                seedWithDemoData()
        }
    }
    private func seedWithDemoData(){
        self.slides.append(contentsOf: [
            Slide(title: "Sunset",
                  imgFileName: "sunset-10"),
            Slide(title: "At the beach",
                  imgFileName: "sunset-11")])
    }
}
