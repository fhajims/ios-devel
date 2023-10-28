//
//  WebService.swift
//  omd-ios-devel-chapter-02-UnitTesting
//
//  Created by John on 31.01.23.
//

// TODO read "Bundle" (i.e. from Info.plist)
/*
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Host</key>
    <string>berkeley.fh-joanneum.at</string>
    <key>Path</key>
    <string>/api/heroes</string>
    <key>Port</key>
    <integer>80</integer>
    <key>Scheme</key>
    <string>http</string>
</dict>
</plist>
*/


// For http we need to allow this EXPLICITely (in Info.plist)
// ATS = App Transport Security
//  Otherwise, error:
//      "The resource could not be loaded because the App Transport Security policy requires the use of a secure connection." UserInfo={NSLocalizedDescription=The resource could not be loaded because the App Transport Security policy requires the use of a secure connection., NSErrorFailingURLStringKey=http://berkeley.fh-joanneum.at:80/api/heroes/1
/*
 
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <dict>
     <key>NSAppTransportSecurity</key>
     <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
     </dict>
 </dict>
 </plist>

 */



import Foundation
class WebServiceClient {
    func fetchData(heroID:Int ) async throws -> String{
        // We assume, you added configuration settings
        // for Scheme, Port, Host, Path to your Info.plist (beware the entries are case sensitive)
        let configPort = Bundle.main.object(forInfoDictionaryKey: "Port") as? Int ?? 443
        let configScheme = Bundle.main.object(forInfoDictionaryKey: "Scheme") as? String ?? "https"
        let configHost = Bundle.main.object(forInfoDictionaryKey: "Host") as? String ?? "berkeley.fh-joanneum.edu"
        let configPath = Bundle.main.object(forInfoDictionaryKey: "Path") as? String ?? "/api/v2/heroes"
        
        var composeURL=URLComponents()
        composeURL.scheme = configScheme
        composeURL.port=configPort
        composeURL.host=configHost
        composeURL.path=configPath + "/\(heroID)"

        // e.g. http://berkeley.fh-joanneum.at:80/api/heroes/1
        guard let curr_url = composeURL.url else{
                        throw FetchImageErr.improperURL
        }

        print("We try to access server \(configHost) via \(configScheme) on port \(configPort) to get heroes at path \(configPath): \(curr_url)")
        let request = URLRequest(url: curr_url)
        
        let (data,response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{
            throw FetchImageErr.improperURL
        }

        let decoder = JSONDecoder()
        guard let entry = try? decoder.decode(HerosAPI.self, from: data) else {
            throw FetchImageErr.imageDataDecodingError
        }

        return entry.name
    }
}
