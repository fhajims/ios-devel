//
//  omd_ios_devel_chapter_06_ConcurrencyApp.swift
//  omd-ios-devel-chapter-06-Concurrency
//


// Requirements 1: see Info.plist
//
// http ... <= we MUST use https (or set exception in info.plist)
//    <dict>
//        <key>NSAppTransportSecurity</key>
//        <dict>
//            <key>NSExceptionDomains</key>
//            <dict>
//                <key>berkeley.fh-joanneum.at</key>
//                <dict>
//                    <key>NSExceptionAllowsInsecureHTTPLoads</key>
//                    <true/>
//                    <key>NSIncludesSubdomains</key>
//                    <true/>
//                </dict>
//            </dict>
//        </dict>
//    </dict>
//
// Add App Transport Security Exception Domains
// Otherwise:
//    App Transport Security has blocked a cleartext HTTP connection since it is insecure.
//     Use HTTPS instead or add Exception Domains to your app's Info.plist....

// Requirements 2: define enums for errors, see model/CustomErrors.swift

// Requirements 3: define struct for deserialising json into in memory objects, see model/HerosAPI.swift



// Requirements 4a: for a SINGLE HERO
//     provide async function "fetchHeroById" to get code, see service/api.swift

// Requirements 4ab: for  MANY (a list of heros)  HERO
//     provide async function "fetchHeroById" to get code, see service/api.swift





import SwiftUI

@main
struct omd_ios_devel_chapter_06_ConcurrencyApp: App {
    let vm = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(manyHeroesViewModel:vm)
        }
    }
}
