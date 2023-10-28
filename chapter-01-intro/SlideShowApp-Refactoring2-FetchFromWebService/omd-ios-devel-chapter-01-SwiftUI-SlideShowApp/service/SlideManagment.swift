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
        if withInitialData {
            seedWithDemoData()
            
        }else{
            Task {
                let result = try? await self.fetchListOfSlidesFromWebService()
                
                if let listOfSlides = result?.0, let title = result?.1 {
                    slides.append( contentsOf: listOfSlides)
                    slideshowTitle = title
                }
            }
        }
    }

    func toggleFavorite(_ slide:Slide)->Slide{
        guard var modSlide = self.slides.first(where: {$0.id == slide.id} )else { return slide }
        print("DEBUG: Update slide \(modSlide) within the slides: \(slides)")
        
        // Note: You Can NOT MODIFY structs within a list with (because s is a copy, NOT a REFERENCE):
        modSlide.isFavorite = !modSlide.isFavorite
        // You have to update the proper slide WITHIN the collection!
        updateSlideInCollection(with: modSlide)
        print("DEBUG:                to: \(slides)")
        return modSlide
    }
    func updateSlideInCollection(with slide :Slide){
        slides.indices.filter { slides[$0].id == slide.id }.forEach { slides[$0].isFavorite = slide.isFavorite }
    }
    
    
    func slideAfter(slide:Slide) -> Slide? {
        guard var currIdx:Int = self.slides.firstIndex(of: slide) else {
            return slide
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


// provide async functionality to fetch data from web service endpoint
// Step-by-step:
//    prepare URL (from string) to prepare a request (from url)
//    fetch data: `URLSession.shared.data` and check response (status code)
//    decode JSON (to object containing list of slides)

extension SlideManager {
    func fetchListOfSlidesFromWebService() async throws -> ([Slide],String) {
        
        // URL
        // Note: loading settings from Info.plist (property file)
        /*
            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">
            <dict>
                <key>SlideWebServiceUrl</key>
                <!-- http is only valid for testing at localhost, otherwise https required! -->
                <string>http://localhost:8000/holidayslideshow.json</string>
            </dict>
            </plist>
         */
        //       is much(!) better than hard coded strings, such as:
        //       let slideshowUrlString = "http://localhost:8000/holidayslideshow.json"
        guard let slideshowUrlString = Bundle.main.object(forInfoDictionaryKey: "SlideWebServiceUrl") as? String else {
            print("Err. Please provide the url string in the Info.plist as 'SlideWebServiceUrl'.")
            throw WebServiceError.noUrlDefinedInInfoPropertyList
        }
        
        guard let slideshowUrl = URL(string: slideshowUrlString) else {
            throw WebServiceError.invalidURL
        }
        print("Loding from \(slideshowUrl)...")
        
        
        // FETCH DATA
        let wsRequest = URLRequest(url:slideshowUrl)
        let (data, response) = try await URLSession.shared.data(for: wsRequest)
        print(" We got some raw data from the web service: '\(data.debugDescription)' ")
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {throw WebServiceError.unexpectedStatusCode }

        print(" Data as string: '\(String.init(data: data, encoding: .utf8) ?? "Sorry, we cannot show data as UTF-8 string")' ")

        // DECODE JSON
        let decoder = JSONDecoder()
        
        // During debugging:
//        do{
//            let fetchedSlideshow = try decoder.decode(
//                Slideshow.self, from: data)
//            print("We fetched slideshow: '\(fetchedSlideshow)'")
//        }catch let DecodingError.keyNotFound(key,context){
//            print("Error, key '\(key)' not found.")
//            print("CodingPath: '\(context.codingPath)'.")
//            print("Context: '\(context.debugDescription)'.")
//        }catch let DecodingError.dataCorrupted(context){
//            print("codingPath:", context.codingPath)
//        }catch let DecodingError.typeMismatch(type, context)  {
//            print("Type '\(type)' mismatch:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//        }
        
        guard let fetchedSlideshow =
                try? decoder.decode(
                        Slideshow.self, from: data) else {
                print("ERROR Decoding given data as valid Slideshow data. Check the JSON structure and try again.")
                throw WebServiceError.slideshowDataDecodingError
        }
        print("We fetched slideshow: '\(fetchedSlideshow.title)' containing \(fetchedSlideshow.slides.count) slides")
        return (fetchedSlideshow.slides,fetchedSlideshow.title)
    }
}

