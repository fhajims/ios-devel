//
//  WebServiceError.swift
//  omd-ios-devel-chapter-02-UnitTesting
//
//  Created by John on 31.01.23.
//

import Foundation


enum FetchImageErr: Error {
    case improperURL
    case imageDataDecodingError
    case imageError
}
