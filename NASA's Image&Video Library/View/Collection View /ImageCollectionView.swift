//
//  ImageCollectionView.swift
//  NASA's Images App
//
//  Created by macintosh on 02/03/2021.
//

import UIKit

final class ImageCollectionView: UICollectionView {
    private let imageDataSource = ImageDataSource()
    
    init() {
        // Sets custom layout class
        super.init(frame: .zero, collectionViewLayout: ImageCollectionViewFlowLayout())
        // Configures collection view
        self.configureItself()
        // Sets custom data source
        self.register(ImageCollectionViewCell.self,
                      forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        self.dataSource = self.imageDataSource
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureItself() {
        self.backgroundColor = .clear
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    
}
