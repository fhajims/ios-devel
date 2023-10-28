//
//  CustomErrors.swift
//  omd-ios-devel-chapter-06-Concurrency
//
//  Created by John on 03.11.21.
//

import Foundation
enum FetchImageErr: Error {
    case improperURL
    case imageDataDecodingError
    case imageError
    case thumbNailCreationError
    case LoadingError
}
