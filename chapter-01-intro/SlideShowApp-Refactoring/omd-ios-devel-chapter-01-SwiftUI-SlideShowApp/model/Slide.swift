//  Slide.swift

import Foundation

// Allow slides to be managed by collections (contains, sorted) and
// allow slides to be managed by lists (insert, delete).
struct Slide:Equatable, Identifiable {
    let id:UUID = UUID()
    var title:String
    var imgFileName:String? = nil
    var description:String? = nil
    var isFavorite:Bool = false
}
