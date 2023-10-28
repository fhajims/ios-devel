//
//  HerosAPI.swift
//  omd-ios-devel-chapter-06-Concurrency
//
//  Created by John on 03.11.21.
//

import SwiftUI

struct Heroes:Codable {
    var heroes: [Hero]
}

// we start simple, ie. for a single hero
struct Hero: Codable{
    var id: Int
    var name:String
    var desc:String?
    var imageName:String?  // base64 encoded
    
    // define which keys will be considered and possilby map the keys
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case desc = "description"
        case imageName = "image"
    }
    
}


extension Hero{
    var uiimage: UIImage? {
        get {
            // self.image = "data:image/png;base64,iVB..."
            guard let imgName = self.imageName,
                  !imgName.isEmpty ,
                  let imgDataSubString:Substring = imgName.split(separator: ",").last,
                  let d = Data(base64Encoded: String(imgDataSubString)) else {
                      print("\t\tSorry, we could not create an image from the base64 string for hero \(self.id).")
                      return nil
                  }
            print("\t *** OK, we created a UIImage from the given Base64 string for hero \(self.id).")
            return UIImage(data: d)
        }
    }
}


// for many heros: (display in list)
extension Hero:Identifiable{
    
}
