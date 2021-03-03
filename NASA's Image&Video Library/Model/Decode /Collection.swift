//
//  DecodeImages.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 03/03/2021.
//

import Foundation

struct Collection: Decodable {
    let collection: Images
    
    struct Images: Decodable {
        let images: [Image]
        
        enum CodingKeys: String, CodingKey {
            case images = "items"
        }
    }
    
    struct Image: Decodable {
        let data: [ImageData]
        let resources: [ImageResources]
        
        enum CodingKeys: String, CodingKey {
            case data = "data"
            case resources = "links"
        }
    }
    
    struct ImageResources: Decodable {
        let imageURL: URL
        
        enum CodingKeys: String, CodingKey {
            case imageURL = "href"
        }
    }
    
    struct ImageData: Decodable {
        let title: String
        let description: String?
        let location: String?
        let photographer: String?
    }
}



