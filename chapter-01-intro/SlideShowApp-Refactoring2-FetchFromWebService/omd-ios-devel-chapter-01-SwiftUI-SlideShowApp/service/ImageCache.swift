//
//  ImageCache.swift
//  omd-ios-devel-chapter-01-SwiftUI-SlideShowApp
//
//  Created by john on 22.04.22.
//

import UIKit

class ImageCache {
    private var cachedImages:[String:UIImage] = [:]
    private init(){}
    public static let shared:ImageCache = ImageCache()

    // usage:
    //   ImageCache.shared[ k ] = v
    //   v = ImageCache.shared[ k ]
    subscript(_ key:String) -> UIImage? {
        get {
           return cachedImages[key]
        }
        set (anotherUIImg){
            // TODO: Optionally, limit cache to maximal 10 elements or so
            cachedImages[key] = anotherUIImg
        }
    }
    
    
    // better than:
    /*
    func add(key:String, img:UIImage?){
        cachedImages[key] = img
    }
    func get(key:String) -> UIImage?{
        return cachedImages[key]
    }
     */
}
