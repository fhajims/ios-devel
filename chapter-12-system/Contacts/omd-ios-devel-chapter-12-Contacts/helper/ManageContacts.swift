//
//  ManageContacts.swift
//  omd-ios-devel-chapter-12-Contacts
//
//  Created by John on 31.01.23.
//

import Foundation

import Contacts

/*
 Note: Add NSContactsUsageDescription to Info.plist
 
 Otherwise, errror:
 
    ...This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSContactsUsageDescription key with a string value explaining to the user how the app uses this data....
 */

struct Friend:Identifiable{
    let id:UUID=UUID()
    var name:String
}
class ContactManagement{
    static let shared = ContactManagement()
    private init(){}

    func fetchSomeContacts() async -> [Friend]{
        var names:[Friend] = []
        let predicate = CNContact.predicateForContacts(matchingName: "Appleseed")
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey] as [CNKeyDescriptor]
        
        print("Feetching with predicate: \(predicate)...")
        
        let store = CNContactStore()
        do {
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
            print("Fetched contacts: \(contacts)")
            for contact in contacts {
                names.append(Friend(name:contact.givenName))
            }
        } catch {
            print("Failed to fetch contact, error: \(error)")
            // Handle the error.
        }
        
        return names
    }

}
