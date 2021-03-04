//
//  ImageCollectionViewFlowLayout.swift
//  NASA's Images App
//
//  Created by macintosh on 02/03/2021.
//

import UIKit

final class ImageCollectionViewFlowLayout: UICollectionViewFlowLayout {
    // MARK: - Size's Constants
    
    private let lineSpacing: CGFloat = UIConstants.unitedInset
    private let cellSpacing: CGFloat = UIConstants.unitedInset
    private let contentInset: CGFloat = UIConstants.unitedInset
    private let widthCellSize: CGFloat = UIScreen.main.bounds.width / 2 - UIConstants.unitedInset - UIConstants.unitedInset / 2
    private let heightCellSize: CGFloat = 1.2 * (UIScreen.main.bounds.width / 2 - UIConstants.unitedInset - UIConstants.unitedInset / 2)
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        // Configures Layout
        self.configureLayout()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Configuration
    func configureLayout() {
        self.scrollDirection = .vertical
        
        self.itemSize = CGSize(width: self.widthCellSize, height: self.heightCellSize)
        self.minimumLineSpacing = self.lineSpacing
        self.minimumInteritemSpacing = self.cellSpacing
        self.sectionInset = UIEdgeInsets(top: self.contentInset,
                                         left: self.contentInset,
                                         bottom: self.contentInset,
                                         right: self.contentInset)
    }
    
}
