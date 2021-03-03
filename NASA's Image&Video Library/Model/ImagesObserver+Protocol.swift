//
//  ImagesObserver+Protocol.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 03/03/2021.
//

import Foundation

protocol ImagesObserver: class {
    func didImagesStartLoading(_ images: Images)
    func didNoInternetConnection(_ images: Images)
    func didNetworkingErrorOccured(_ images: Images, error: NetworkingError)
    func didImagesFinishLoading(_ images: Images, image: [Images.ImageModel])
}

extension ImagesObserver {
    func didImagesStartLoading(_ images: Images) { }
    func didNoInternetConnection(_ images: Images) { }
    func didNetworkingErrorOccured(_ images: Images, error: NetworkingError) { }
    func didImagesFinishLoading(_ images: Images, image: [Images.ImageModel]) { }
}
