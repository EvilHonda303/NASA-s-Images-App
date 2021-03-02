//
//  Endpoint.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 02/03/2021.
//

import Foundation


// Defines API's Endpoints by path and query
// - One RESTful API has only one domain (host)
// - RESTful API may be specified by
//   - path (to the concrete resource)
//   - query (parameters that clarify data that client would like to CRUD

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

// Defines URL that will be passed to the data task!
extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
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
    static func searchByText(text: String) -> Self {
        let query: [URLQueryItem] = [URLQueryItem(name: "page", value: "1"),
                                     URLQueryItem(name: "query", value: text),
                                     URLQueryItem(name: "client_id", value: "KO7MLYeY2xPlv0exFrbyNV6HFep5r9qf6an1_Nnxl3k")]
        let path = "search/photos"
        
        return Endpoint(path: path, queryItems: query)
    }
}
