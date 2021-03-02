//
//  ViewController.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 02/03/2021.
//

import UIKit

class ImageController: UIViewController {
    let imageCollection = ImageCollectionView()
    let imageSearchBar = ImageSearchBar()
    let NASAImageView = UIImageView()
    
    override func viewDidLoad() {
        // Configures content view
        self.configureContentView()
        // Sets view's hierarchy
        self.view.addSubview(self.imageCollection)
        self.view.addSubview(self.imageSearchBar)
        self.view.addSubview(self.NASAImageView)
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

