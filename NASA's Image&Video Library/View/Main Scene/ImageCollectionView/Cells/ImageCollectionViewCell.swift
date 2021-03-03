//
//  ImageCollectionViewCell.swift
//  NASA's Images App
//
//  Created by macintosh on 02/03/2021.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ImageCollectionViewCell"
    
    private let imageView = UIImageView()
    private let spinner = UIActivityIndicatorView()
    
    // MARK: - Initializator
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Adjusts view's hiearchy of cell
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.spinner)
        // Configures views of the hierarchy
        self.configureContentView()
        self.configureImageView()
        self.configureSpinner()
        // Adds constraints to views of the hierarchy
        self.addConstraintsToImageView()
        self.addConstraintsToSpinner()
        
        self.backgroundColor = .clear
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configureContentView() {
        self.contentView.backgroundColor = .superViolet
        
        self.contentView.clipsToBounds = true
        
        // borders
        self.contentView.layer.borderWidth = 3.0
        self.contentView.layer.borderColor = UIColor.white.cgColor
        self.contentView.layer.cornerRadius = 20.0
    }
    
    private func configureImageView() {
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
    }
    
    private func configureSpinner() {
        self.spinner.backgroundColor = .clear
        self.spinner.hidesWhenStopped = true
        self.spinner.style = .whiteLarge
    }
    
    // MARK: - Constraints
    
    private func addConstraintsToImageView() {
        guard let superView = self.imageView.superview else {
            return
        }
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.imageView.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 1.0).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 1.0).isActive = true

    }
    
    private func addConstraintsToSpinner() {
        guard let superView = self.spinner.superview else {
            return
        }
        
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }
    
    // View Update (MVC)
    func update(dispalying image: UIImage?) {
        if let image = image {
            spinner.stopAnimating()
            imageView.image = image
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
    func update(with url: URL?) {
        
    }
}
