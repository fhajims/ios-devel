//
//  ManageListOfSlidesView.swift
//  omd-ios-devel-chapter-01-SwiftUI-SlideShowApp
//
//  Created by John on 26.04.22.
//

import SwiftUI

struct ManageListOfSlidesView: View {
    
    @EnvironmentObject var slideManager:SlideManager
    
    var body: some View {
        List(slideManager.slides) { slide in
            Text(slide.title)
        }
    }
}

struct ManageListOfSlidesView_Previews: PreviewProvider {
    static var previews: some View {
        ManageListOfSlidesView()
    }
}
