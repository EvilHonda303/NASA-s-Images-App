//
//  Endpoint+Extension.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 03/03/2021.
//

import Foundation

// Defines URL that will be passed to the data task!
extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "images-api.nasa.gov"
        components.path = "/" + self.path
        components.queryItems = self.queryItems
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        
        return url
    }
}

// Concrete URLs
extension Endpoint {
    // fetch all images from Image&Video Gallery
    static func fetchImages() -> Self {
        let query: [URLQueryItem] = [URLQueryItem(name: "q", value: ""),
                                     URLQueryItem(name: "media_type", value: "image"),
                                     URLQueryItem(name: "year_start", value: "2021")]
        let path = "search"
        
        return Endpoint(path: path, queryItems: query)
    }
}
