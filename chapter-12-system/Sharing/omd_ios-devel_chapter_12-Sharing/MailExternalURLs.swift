//
//  MailExternalURLs.swift
//  omd_ios-devel_chapter_12-Sharing
//
//  Created by John on 05.01.21.
//

import SwiftUI

public class MailExternalURLsHelper {
    
    // see: https://stackoverflow.com/questions/56784722/swiftui-send-email
    // First, add to Info.plist
    // <key>LSApplicationQueriesSchemes</key>
    //    <array>
    //        <string>googlegmail</string>
    //        <string>ms-outlook</string>
    //        <string>readdle-spark</string>
    //        <string>ymail</string>
    //    </array>
    
    // Then, build sending mail strings
    // for Gmail, Outlook, Yahoo, Spark,...
    public static func createEmailUrl(app:UIApplication,  subject: String, body: String) -> URL? {
        let to = "send.to@your.provider.com"
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")

        let mailToSubjectBody = "\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)"
            
        let gmailUrl = URL(string: "googlegmail://co?to=\(mailToSubjectBody)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(mailToSubjectBody)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(mailToSubjectBody)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(mailToSubjectBody)")
        

        if let gmailUrl = gmailUrl, app.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, app.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, app.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, app.canOpenURL(sparkUrl) {
            return sparkUrl
        }

        return defaultUrl
    }
}
