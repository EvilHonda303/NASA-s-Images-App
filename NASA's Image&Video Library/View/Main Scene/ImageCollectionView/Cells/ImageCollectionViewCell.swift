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
    private let imageTitleLabel = UILabel()
    
    private var defaultImage = UIImage(named: "nasa-logo")
    
    // MARK: - Initializator
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Adjusts view's hiearchy of cell
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.spinner)
        self.contentView.addSubview(self.imageTitleLabel)
        
        // Configures views of the hierarchy
        self.configureContentView()
        self.configureImageView()
        self.configureSpinner()
        self.configureImageTitleLabel()
        
        // Adds constraints to views of the hierarchy
        self.disableAutoresizingMasks()
        
        self.addConstraintsToImageView()
        self.addConstraintsToSpinner()
        self.addConstraintToImageViewAndTitleLabel()
        self.addConstraintsToImageTitleLabel()
        
        self.backgroundColor = .clear
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Preparing For Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.imageTitleLabel.text = nil
        self.spinner.stopAnimating()
    }
    
    // MARK: - Configuration
    
    private func configureContentView() {
        self.contentView.clipsToBounds = true
    }
    
    private func configureImageView() {
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        
        self.imageView.layer.cornerRadius = UIConstants.imageCellCornerRadius
        
        //self.dropShadow()
    }
    
    private func configureSpinner() {
        self.spinner.backgroundColor = .clear
        self.spinner.hidesWhenStopped = true
        self.spinner.style = .whiteLarge
    }
    
    private func configureImageTitleLabel() {
        self.imageTitleLabel.font = .systemFont(ofSize: UIConstants.imageTitleFontSize)
        self.imageTitleLabel.textColor = .white
        
        self.imageTitleLabel.textAlignment = .left
        self.imageTitleLabel.numberOfLines = 1

    }
    
    // MARK: - Constraints
    
    func disableAutoresizingMasks() {
        self.contentView.subviews.forEach { sub in
            sub.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func addConstraintsToImageView() {
        guard let superView = self.imageView.superview else {
            return
        }

        self.imageView.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 1.0).isActive = true
        self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 1.0).isActive = true

    }
    
    private func addConstraintsToSpinner() {
        guard let superView = self.spinner.superview else {
            return
        }

        self.spinner.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }
    
    private func addConstraintToImageViewAndTitleLabel() {
        self.imageTitleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10.0).isActive = true
    }
    
    private func addConstraintsToImageTitleLabel() {
        guard let superView = self.imageTitleLabel.superview else {
            return
        }
 
        self.imageTitleLabel.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.imageTitleLabel.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 1.0).isActive = true
    }
    
    func update(with image: UIImage?, title: String) {
        self.imageView.image = image
        self.imageTitleLabel.text = title
    }
    
    func update(with url: URL, title: String, completionHandler: @escaping (UIImage?) -> ()) {
        // enables loading state
        self.spinner.startAnimating()
        self.imageTitleLabel.text = title
        
        DispatchQueue.global(qos: .utility).async {
            if let imageData = try? Data(contentsOf: url),
               let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                    self.imageView.image = image
                    completionHandler(image)
                }
            } else {
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                    self.imageView.image = self.defaultImage
                    completionHandler(self.defaultImage)
                }

            }
        }
    }
}

