//
//  ManyHerosViewModel.swift
//  omd-ios-devel-chapter-06-Concurrency
//
//  Created by john on 09.02.22.
//

import Foundation
import UIKit

class ViewModel:ObservableObject{
    @Published var heros: [Hero] = []
    
    init(showDemoData:Bool=false){
        if showDemoData {
            addSomeDemoHeroes()
        }
        Task{
            //await addSomeDemoHeroesFromTimeToTime()
            for idx in 111...999 {
                // after 3 secs we should get a hero
                let h = await addAnotherHeroFromTimeToTime(idx)
                /* Note: switch to main queue. I.e. fix for
                    Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
                */
                DispatchQueue.main.async {
                    self.heros.append(h)
                }
            }
        }
        
        Task{
            if let heros:[Hero] = try? await fetchListOfHeroes() {
                self.heros.append(contentsOf:heros)
            }
        }
    }
    
    func prepareURL(id:Int? = nil) throws -> URL?{
        guard let apiScheme = Bundle.main.object(forInfoDictionaryKey: "ApiScheme") as? String,
              let apiServer = Bundle.main.object(forInfoDictionaryKey: "ApiServer") as? String,
              let apiPortStr = Bundle.main.object(forInfoDictionaryKey: "ApiPort") as? String,
              let apiPort = Int(apiPortStr)
            else {
            print("Err. Please provide the url string in the Info.plist as 'ApiScheme', 'ApiServer', and 'ApiPort'.")
            throw WebServiceError.noUrlDefinedInInfoPropertyList
        }

        var buildTheURL = URLComponents()
        buildTheURL.scheme = apiScheme          // http
        buildTheURL.host = apiServer            // localhost
        buildTheURL.port = apiPort              // 8000
        if let heroId = id {
            buildTheURL.path = "/\(heroId).json" // 3.json
        }else{
            buildTheURL.path = "/heroes.json"     // heros.json
        }
        print("Debug: we try to fetch from '\(String(describing: buildTheURL.url))'...") // e.g.: http://localhost:8000
        return buildTheURL.url
    }
    func fetchListOfHeroes() async throws -> [Hero]{
        print("Loading some (the list of) heros via the API (possibly async in the background)... ")
        guard let herosURL = try? prepareURL() else { throw FetchImageErr.improperURL }
        // try: curl http://localhost:8000/heros.json

        // FETCH DATA
        let herosReq = URLRequest(url: herosURL)
        let (data, response) = try await URLSession.shared.data(for: herosReq)
        print(" List of heros b data = '\(data.debugDescription)' ") // todo output only first few chars...
        print(" converted to string: '\(String(data:data,encoding: .utf8) ?? "ERR: cannot decode data")" )
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {throw WebServiceError.unexpectedStatusCode }
        
        // DECODE JSON
        let decoder = JSONDecoder()
        do {
            let loadedHeros = try decoder.decode(Heroes.self, from: data)
            print("  Heros: = '\(loadedHeros)' ")
            return loadedHeros.heroes
        }catch let e  {
            print("Err on converting from JSON to in-memory object tree: \(e)")
            throw WebServiceError.dataDecodingError
        }
        
        // shorter (but we cannot output the error details):
        /*
         guard let loadedHeros = try? decoder.decode(Heroes.self, from: data) else {throw FetchImageErr.imageDataDecodingError }
         return loadedHeros.heroes
        */
    }

    func fetchThumbnail(`for` heroId: Int) async throws -> UIImage {
        guard let thumbURL = try? prepareURL(id:heroId) else { throw FetchImageErr.improperURL }
        // try: curl http://localhost:8000/3.json

        print("  \(heroId): a) url = \(thumbURL.absoluteString)")
        
        // FETCH DATA
        let thumbReq = URLRequest(url: thumbURL)
        let (data, response) = try await URLSession.shared.data(for: thumbReq)
        print("  \(heroId): b data = '\(data.debugDescription)' ") // todo output only first few chars... 
        guard let r = response as? HTTPURLResponse else { throw FetchImageErr.imageError}
        guard r.statusCode == 200 else {
            print("ERR: we got unexpecet statusCode of \(r.statusCode)")
            throw FetchImageErr.imageError
        }
        
        
        // DECODE JSON
        let decoder = JSONDecoder()
        guard let loadedHero = try? decoder.decode(Hero.self,
                                                   from: data) else {throw FetchImageErr.imageDataDecodingError }
        print("  \(heroId): c hero-object = '\(loadedHero)' ")
        
        // IMAGE from Base64 String
        let maybeImage:UIImage? = loadedHero.uiimage // see hero conversion from base64 "image" string to uiimage
        print("  \(heroId): d image = '\(maybeImage?.description ?? "NO-IMAGE")' ")
        
        // CREATE THUMB
        guard let thumbnail = await maybeImage?.thumbnail else {throw FetchImageErr.thumbNailCreationError }
        print("  \(heroId): e thumb = '\(thumbnail)')' ")
        
        // RETURN thumb (if no error occured so far)
        return thumbnail
    }
    
    

    private func addAnotherHeroFromTimeToTime(_ idx:Int) async -> Hero{
        sleep(3)
        return Hero(id: idx, name: "Hero-\(idx)", desc: "Superhero number \(idx).", imageName: "placeholder")
    }
    /*
    private func addSomeDemoHeroesFromTimeToTime() async {
        for idx in 111...999 {
            self.heros.append(Hero(id: idx, name: "Hero-\(idx)", desc: "Superhero number \(idx).", imageName: "placeholder"))
            sleep(3)
        }
    }
     */
    private func addSomeDemoHeroes(){
        self.heros.append(contentsOf: [
            Hero(id: 1, name: "Superman", desc: "super"),
            Hero(id: 2, name: "Aquaman", desc: "aqua"),
            Hero(id: 3, name: "Asterix", desc: "aster"),
            Hero(id: 4, name: "The Atom", desc: "atom"),
            Hero(id: 5, name: "Avengers", desc: "aven")
        ])
        for idx in 10...59 {
            self.heros.append(Hero(id: idx, name: "Hero-\(idx)", desc: "Superhero number \(idx).", imageName: "placeholder"))
        }
    }
}
