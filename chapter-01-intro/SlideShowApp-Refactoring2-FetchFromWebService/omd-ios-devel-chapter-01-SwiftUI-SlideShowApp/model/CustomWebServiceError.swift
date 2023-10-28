//
//  CustomWebServiceError.swift
//  omd-ios-devel-chapter-01-SwiftUI-SlideShowApp
//
//  Created by John on 21.04.22.
//

import Foundation

enum WebServiceError: Error {
    case noUrlDefinedInInfoPropertyList
    case invalidURL
    case unexpectedStatusCode
    case slideshowDataDecodingError
}
