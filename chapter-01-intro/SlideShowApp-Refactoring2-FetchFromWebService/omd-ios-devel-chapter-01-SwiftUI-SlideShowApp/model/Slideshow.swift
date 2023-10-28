//
//  Slideshow.swift
//  omd-ios-devel-chapter-01-SwiftUI-SlideShowApp
//
//  Created by John on 21.04.22.
//

import Foundation

/* Compare the strucutre of input JSON
 {
            "slides" : [
               {
                  "file" : "sunset-10.jpeg",
                  "id" : 10
               },
               {
                  "file" : "sunset-13.jpeg",
                  "id" : 13
               }
            ],
            "title" : "Holiday Slideshow"
         }
 
 */

struct Slideshow:Decodable {
    var title:String
    var slides:[Slide]
}
