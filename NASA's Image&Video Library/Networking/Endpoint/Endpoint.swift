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

