import UIKit

var greeting = "Demo fetch data async ... and deserialise json to in memory objects"

enum FetchImageErr: Error {
    case improperURL
    case imageDataDecodingError
    case imageError
}
struct HerosAPI: Codable{
    var id: Int
    var name:String
    var description:String
    var image:String
}


func fetchAnImage(nr:Int) async throws -> UIImage {

    // better avoid compose URL as one single string
    // guard let curr_url = URL(string: "http://berkeley.fh-joanneum.at/api/heroes/1") else {

    // Use URLComponents to compile your URLs (in a more flexible way):
    var buildTheURL = URLComponents()
    buildTheURL.scheme = "http"
    buildTheURL.host = "berkeley.fh-joanneum.at"
    buildTheURL.path = "/api/heroes/\(nr)" // always start with "/"
    // print("We composed the url as '\(String(describing: buildTheURL.url)).")
    guard let curr_url = buildTheURL.url else {
        print("Sorry, the url is not valid.")
        throw FetchImageErr.improperURL
    }
    print("Now start the download from \(curr_url)...")
    let request = URLRequest(url: curr_url)
    
    let (data,response) = try await URLSession.shared.data(for: request)
    
    guard (response as? HTTPURLResponse)?.statusCode == 200 else{
        throw FetchImageErr.improperURL
    }
    
    // print( String(bytes:data, encoding:  .utf8) ?? "ERR - no JSON data retrieved.")
    
    let decoder = JSONDecoder()
    
    if let entry = try?
        
        decoder.decode(HerosAPI.self, from: data) { // Note: data:image/png;base64,iVB...
        print(
            """
             Data-entry:
               id          = '\(entry.id)'
               description = '\(entry.description)'
               name        = '\(entry.name)'
               length      = '\( entry.image.lengthOfBytes(using: .utf8))'
            """)
        
        // special handling of base64 image data, because the backend
        // returns two different formats (with/without prefix: 'data:image/png;base64,')
        let imgData=entry.image.split(separator: ",") // sometimes img data starts with "data:image/png;base64,"
        var imgDataString:String = String(imgData.first ?? "") // iVBORw0KGgoAAAANSU....
        if imgData.count >= 2 {
             // print(imgData[0]) // data:image/png;base64
            imgDataString = String(imgData[1]) // iVBORw0KGgoAAAANSU....
        }
        print(imgDataString) // iVBORw0KGgoAAAANSU....
        guard let d = Data(base64Encoded: imgDataString) else {
            print("FETCH-ERR")
            throw FetchImageErr.imageError
        }
        let maybeImage = UIImage(data: d)
        guard let anImage = maybeImage else {
            print("IMG-ERR")
            throw FetchImageErr.imageError
        }
        print(" IMG-ok")
        return anImage
        
    }
    print("IMG-DATA-ENCODING-ERR")
    throw FetchImageErr.imageDataDecodingError
}

var img: UIImage? = nil
Task {
    img = try? await fetchAnImage(nr:2)
    print(" The final image we got: '\(img?.description ?? "X")'.")

    img = try? await fetchAnImage(nr:4)
    print(" The final image we got: '\(img?.description ?? "X")'.")
    
    print("Check out the image loaded (i.e. view the variable img in the live-view on the right).")

}
print(" The image is being loaded in the background.")
