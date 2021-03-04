//
//  DetailViewController.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 02/03/2021.
//

import UIKit

// Manages Detail Scene

// UI States:
//  - Shows all model's info on the screen
//  - Shows UIActivityIndicator if image's data haven't loaded yet

final class DetailController: UIViewController {
    // Model Layer
    private var imageModel: Images.ImageModel!
    private var image: UIImage?
    
    // UI Layer
    let scrollView = UIScrollView()
    
    let imageView = UIImageView()
    let spinner = UIActivityIndicatorView()
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let photographerLabel = UILabel()
    let locationLabel = UILabel()
    
    // MARK: Life Cycle Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .fruitDove
        
        // Adjust Hierarchy
        
        self.view.addSubview(self.scrollView)
        for label in [self.titleLabel, self.descriptionLabel, self.locationLabel, self.photographerLabel] {
            self.scrollView.addSubview(label)
        }
        
        // UI Configuration
        
        self.configureLabels()
        
        // UI Constraints
        
        self.disableAutoresizingMasks()
        self.addConstraintsToScrollViewAtView()
        for label in [self.titleLabel, self.descriptionLabel, self.locationLabel, self.photographerLabel] {
            self.addConstraintsToLabelAtScrollView(label: label)
        }
        
        // Image's state 
        
        if let _ = self.image {
            self.scrollView.addSubview(self.imageView)
            self.configureImageView()
            
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraintsToImageViewAtScrollView()
            self.addConstraintsBetweenLabelsAndImageStateView(imageStateView: self.imageView)
        } else {
            self.scrollView.addSubview(self.spinner)
            self.configureSpinner()
            self.spinner.startAnimating()
            
            self.spinner.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraintsToSpinnerAtScrollView()
            self.addConstraintsBetweenLabelsAndImageStateView(imageStateView: self.spinner)
        }
        
    }
    // MARK: - Passing Data
    
    func passData(model: Images.ImageModel, image: UIImage?) {
        self.imageModel = model
        self.image = image
    }
    
    // MARK: - Configuration
    
    private func configureImageView() {
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        
        self.imageView.image = self.image
    }
    
    private func configureSpinner() {
        self.spinner.style = .whiteLarge
        self.spinner.backgroundColor = .clear
    }
    
    private func configureLabels() {

        self.titleLabel.text = self.imageModel.title
        self.descriptionLabel.text = self.imageModel.description
        
        if let photographer = self.imageModel.photographer {
            self.photographerLabel.text = "Photographer: \(photographer)"
        }
        
        if let location = self.imageModel.location {
            self.locationLabel.text = "Location: \(location)"
        }
        
        for label in [self.titleLabel, self.descriptionLabel, self.photographerLabel, self.locationLabel] {
            label.numberOfLines = 0
            label.font = .systemFont(ofSize: UIConstants.imageTitleFontSize)
        }
    }
    
    // MARK: - Constraints
    
    private func disableAutoresizingMasks() {
        self.view.subviews.forEach { sub in
            sub.translatesAutoresizingMaskIntoConstraints = false
        }
        self.scrollView.subviews.forEach  { sub in
            sub.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func addConstraintsToScrollViewAtView() {
        guard let superView = self.scrollView.superview else {
            return
        }

        self.scrollView.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        self.scrollView.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 1.0).isActive = true
    }
    
    private func addConstraintsToImageViewAtScrollView() {
        guard let superView = self.imageView.superview,
              let existingImage = self.image else {
            return
        }
        
        let aspectRatio = existingImage.size.height / existingImage.size.width
        
        self.imageView.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: superView.topAnchor, constant: 0.0).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 1.0).isActive = true
        self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: aspectRatio).isActive = true
    }
    
    private func addConstraintsToSpinnerAtScrollView() {
        guard let superView = self.spinner.superview else {
            return
        }
        
        self.spinner.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.spinner.topAnchor.constraint(equalTo: superView.topAnchor, constant: 50.0).isActive = true
    }
    
    private func addConstraintsToLabelAtScrollView(label: UILabel) {
        guard let superView = label.superview else {
            return
        }
        
        label.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    private func addConstraintsBetweenLabelsAndImageStateView(imageStateView: UIView) {
        self.photographerLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -50.0).isActive = true
        self.locationLabel.bottomAnchor.constraint(equalTo: self.photographerLabel.topAnchor, constant: -20.0).isActive = true
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.locationLabel.topAnchor, constant: -20.0).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -20.0).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: imageStateView.bottomAnchor, constant: 50.0).isActive = true
    }
    
}
