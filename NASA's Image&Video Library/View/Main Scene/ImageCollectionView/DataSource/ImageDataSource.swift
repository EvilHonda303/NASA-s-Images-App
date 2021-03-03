//
//  ImageDataSource.swift
//  NASA's Images App
//
//  Created by macintosh on 02/03/2021.
//

import UIKit

final class ImageDataSource: NSObject, UICollectionViewDataSource {
    private var images: Images
    
    init(images storage: Images) {
        images = storage
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! ImageCollectionViewCell
        cell.update(dispalying: nil)
        return cell
    }
    
    
}
