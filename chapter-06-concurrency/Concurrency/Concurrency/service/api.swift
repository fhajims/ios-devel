//
//  api.swift
//  omd-ios-devel-chapter-06-Concurrency
//
//  Created by John on 03.11.21.
//

import SwiftUI

// This source will appear in the
//   omd_ios-devel.pdf book
// Included with:
//   \lstinputlisting{HERE/src/omd-ios-devel-chapter-06-iOS-Concurrency
//                            /omd-ios-devel-chapter-06-iOS-Concurrency
//                            /service/api.swift}
//
// we try the API by M. Knoll
//    {"id":1,"name":"Ant-Man",
//            "description":"Ant-Man ....",
//            "image":"data:image/png;base64,iVBORw0..." }


// START: in the pdf, we show line 25 to line 45: async function
enum WebServiceError: Error {
    case noUrlDefinedInInfoPropertyList
    case invalidURL
    case unexpectedStatusCode
    case dataDecodingError
}

func fetchHero(byID id:Int) async throws -> Hero {
    // let apiBaseURL = "http://berkeley.fh-joanneum.at" +
    //                 "/api/heroes"
    
    
    guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
        print("Err. Please provide the url string in the Info.plist as 'ApiBaseURL'.")
        throw WebServiceError.noUrlDefinedInInfoPropertyList
    }
    print("Debug: we try to fetch from '\(apiBaseURL)'...") // e.g.: http://localhost:8000
    // try: curl http://localhost:8000/1.json
    guard let url = URL(string: "\(apiBaseURL)/\(id).json") else{
        throw FetchImageErr.improperURL
    }
    let req = URLRequest(url: url)
    print("Debug: req-url: '\(req.url?.debugDescription ?? "")'") // e.g.: http://localhost:8000/1.json
    let (data,res) =
    try await URLSession.shared.data(for: req)
    
    guard (res as? HTTPURLResponse)?.statusCode == 200 else {throw FetchImageErr.improperURL}
    
    let decoder = JSONDecoder()
    if let entry = try? decoder.decode(Hero.self,
                                       from: data) {
        return entry // it worked
    }
    throw FetchImageErr.imageDataDecodingError
}


// END: in the pdf, we show line 25 to line 45: async function
