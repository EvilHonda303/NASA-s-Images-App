//
//  ViewController.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 02/03/2021.
//

import UIKit
import Network

class ImageController: UIViewController {
    // Model layer
    let images = Images()
    
    // View layer
    let imageCollection = ImageCollectionView()
    let imageSearchBar = ImageSearchBar()
    let NASAImageView = UIImageView()
    
    // Collection View Data Source
    lazy var imageDataSource: ImageDataSource = ImageDataSource(images: self.images)
    
    override func viewDidLoad() {
        // Configures content view
        images.fetchResults()
        
        self.configureContentView()
        
        // Sets view's hierarchy
        self.view.addSubview(self.imageCollection)
        self.view.addSubview(self.imageSearchBar)
        self.view.addSubview(self.NASAImageView)
        
        // adjust view layer
        self.adjustImageCollection()
        
        // Configures subviews
        self.configureNASAImageView()
        
        // Adds constraints
        self.disableAutoresizingMasks()
        
        self.addConstraintsToNASAImageViewAtView()
        self.addConstraintsToNASAImageViewAndSearchBar()
        self.addConstraintsToSearchBarAtView()
        self.addConstraintsToCollectionAndSearchBar()
        self.addConstraintsToCollectionAtView()
    }
    
    // MARK: - Combine Model&View Layers
    
    func adjustImageCollection() {
        self.imageCollection.register(ImageCollectionViewCell.self,
                                      forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        self.imageCollection.dataSource = self.imageDataSource
    }
    
    // MARK: - Configure
    
    private func configureContentView() {
        self.view.backgroundColor = .fruitDove
    }
    
    private func configureNASAImageView() {
        guard let NASAImage = UIImage(named: "nasa-logo") else {
            return
        }
        
        self.NASAImageView.image = NASAImage
        self.NASAImageView.contentMode = .scaleAspectFill
        self.NASAImageView.clipsToBounds = true
    }
    
    // MARK: - Constraints
    
    func disableAutoresizingMasks() {
        self.view.subviews.forEach { sub in
            sub.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // Methods follows the visual view's hierarchy
    
    private func addConstraintsToNASAImageViewAtView() {
        guard let superView = self.NASAImageView.superview else {
            return
        }

        self.NASAImageView.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor).isActive = true
        self.NASAImageView.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.NASAImageView.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.3).isActive = true
        self.NASAImageView.widthAnchor.constraint(equalTo: self.NASAImageView.heightAnchor, multiplier: 1.25).isActive = true
    }
    
    private func addConstraintsToNASAImageViewAndSearchBar() {
        self.NASAImageView.bottomAnchor.constraint(equalTo: self.imageSearchBar.topAnchor, constant: -UIConstants.unitedInset).isActive = true
    }
    
    
    private func addConstraintsToSearchBarAtView() {
        guard let superView = self.imageSearchBar.superview else {
            return
        }
        
        self.imageSearchBar.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.1).isActive = true
        self.imageSearchBar.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: UIConstants.unitedInset).isActive = true
        self.imageSearchBar.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -UIConstants.unitedInset).isActive = true
    }
    
    private func addConstraintsToCollectionAndSearchBar() {
        self.imageSearchBar.bottomAnchor.constraint(equalTo: self.imageCollection.topAnchor, constant: -UIConstants.unitedInset).isActive = true
    }
    
    private func addConstraintsToCollectionAtView() {
        guard let superView = self.imageCollection.superview else {
            return
        }

        self.imageCollection.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        self.imageCollection.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.imageCollection.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 1.0).isActive = true
    }
}

extension ImageController: ImagesObserver {
    
    // MARK: - Images' Observer Implementation
    
    // calls when:
    //   - app launches
    //   - user tries to load image's database after internet connection failure
    func didImagesStartLoading(_ images: Images) {
        
    }
    
    // calls when:
    //   - loading fails because of the lack of internet connection
    func didNoInternetConnection(_ images: Images) {
        
    }
    
    // calls when:
    //  - any error occurs at the time of request to NASA's Api
    func didNetworkingErrorOccured(_ images: Images, error: NetworkingError) {
        
    }
    
    // calls when:
    //  - all images successfully recieved from the server
    func didImagesFinishLoading(_ images: Images, image: [Images.ImageModel]) {
        
    }
}

