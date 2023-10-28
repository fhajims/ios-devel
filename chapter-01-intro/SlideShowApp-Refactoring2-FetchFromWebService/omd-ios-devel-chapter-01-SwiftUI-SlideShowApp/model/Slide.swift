//  Slide.swift

import Foundation
import UIKit




// Allow slides to be managed by collections (contains, sorted) and
// allow slides to be managed by lists (insert, delete).
struct Slide:Equatable, Identifiable {
    let id:UUID = UUID()
    var title:String
    var imgFileName:String? = nil
    var description:String? = nil
    var isFavorite:Bool = false
    
    // a property, which loads image data in the background on demand:
    var uiImageFromCacheOrWebservice:UIImage?  {
        get async throws{
            // exit function if no image name given. Nothing to do.
            guard let imgFileName = imgFileName else { return nil }
            
            
            // Check CACHE
            //let uiImageCached = ImageCache.shared.get(key:imgFileName)
            let uiImageCached = ImageCache.shared[imgFileName]
            guard uiImageCached == nil else {
                print(" Info: image from cache")
                return uiImageCached
            }
            
            // URL + REQUEST
            guard let webserviceBaseUrlString = Bundle.main.object(forInfoDictionaryKey: "ImageBaseUrl") as? String else {
                print("Err. Please provide the url string in the Info.plist as 'ImageBaseUrl'.")
                throw WebServiceError.noUrlDefinedInInfoPropertyList
            }
            let req = URLRequest(
                  url: URL(string: "\(webserviceBaseUrlString)/\(imgFileName).jpeg")!)
            print("DEBUG: Loading '\(String(describing: req.url))'")
            
            
            // FETCH
            let (data,res) =
                      try await URLSession.shared.data(for: req)
            guard (res as? HTTPURLResponse)?.statusCode == 200 else{
                print("ERR: could not fetch image from '\(String(describing: req.url))'.")
                throw WebServiceError.unexpectedStatusCode
            }
            
            // Network DELAY
            // just for fun (0.8 secs. delay)...
            print(" Simulating some network time overhead")
            try? await Task.sleep(nanoseconds: 800 * 1_000_000)
            
            
            // IMAGE (from data)
            print("We create an image from the data (\(data)) received.")
            let resultingUIimage = UIImage(data: data)
            
            // Update CACHE
            //ImageCache.shared.add(key:imgFileName, img: resultingUIimage)
            ImageCache.shared[imgFileName] = resultingUIimage
            
            return resultingUIimage
        }
    }
}


/* Compare structure of input JSON
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
extension Slide:Codable{
    enum CodingKeys: String, CodingKey {
        case id
        case title
        // We map JSON property 'file'
        case imgFileName = "file"
    }
}


