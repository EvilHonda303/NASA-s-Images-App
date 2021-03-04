//
//  ImageDataSource.swift
//  NASA's Images App
//
//  Created by macintosh on 02/03/2021.
//

import UIKit

// MARK: - Data Source Conformance

final class ImageDataSource: NSObject, UICollectionViewDataSource {
    private var images: [Images.ImageModel]
    private var cache = [UInt : UIImage?]()
    
    init(images storage: [Images.ImageModel]) {
        images = storage
    }
    
    func update(images storage: [Images.ImageModel]) {
        self.images = storage
    }
    
    func fetchModelData(by indexPath: IndexPath) -> (imageModel: Images.ImageModel, image: UIImage?) {
        let id = self.images[indexPath.row].id
        
        return (self.images[indexPath.row],
                self.cache[id] ?? nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! ImageCollectionViewCell
        
        let id = self.images[indexPath.row].id
        let title = self.images[indexPath.row].title
        
        if let cacheImage = cache[id] {
            cell.update(with: cacheImage, title: title)
        } else {
            let imageURL = images[indexPath.row].imageURL
            cell.update(with: imageURL, title: title) { [weak self] loadedImage in
                self?.cache.updateValue(loadedImage, forKey: id)
            }
        }
        
        return cell
    }
}


