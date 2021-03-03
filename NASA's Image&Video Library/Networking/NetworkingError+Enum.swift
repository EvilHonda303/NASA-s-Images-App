//
//  NetworkingError+Enum.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 02/03/2021.
//

import Foundation

enum NetworkingError: String, Error {
    case ResponseError = "Response is failed"
    case ServerError = "Server is not available"
    case DataError = "No data was responsed"
    case MimeTypeError = "Expected mime-type and recieved mime-type don't match"
    case InternetConnectionError = "Check your connection"
}
