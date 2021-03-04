//
//  ViewController.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 02/03/2021.
//

import UIKit

// Manages Main Scene
// Displays three different UI model's ([ImageModel]) states:
// All views are firstly hidden. Some of then appears depending on model's state:
//  - Loading during the launch [NASA Logo (top) + Progress View (middle) + Greetings label (bottom)]
//  - Loading failed (internet connection) [NASA Logo (top) + Explaining Label (middle) + "Try again" Button (bottom)]
//  - Loading failed (server error) [NASA Logo (top) + Explaining Label (middle)]
//  - Loading was successful [NASA Logo (top) + Collection View]

// UI Actions
// - "Try again"'s button tries to load model from API again
// - "Cell" tap creates Detail View Controller

// UI Updates
// - Based on implementation of model's observer [Images' Observer]

class ImageController: UIViewController {
    
    // Model layer
    
    var images = Images()
    
    // Collection View Data Source
    
    var imageDataSource: ImageDataSource!
    
    // View layer
    
    // Collection View UI State
    
    let imageCollection = ImageCollectionView()
    let imageSearchBar = ImageSearchBar()
    let NASAImageView = UIImageView()
    
    // Internet Connection Failure UI State
    let internetConnectionLabel = UILabel()
    let tryAgainButton = UIButton()
    
    // Server Failure UI State
    
    let serverFailLabel = UILabel()
    
    // Loading Images UI State
    
    let launchProgressView = UIActivityIndicatorView()

    
    override func viewDidLoad() {
        // Configures content view
        
        self.configureContentView()
        
        // Sets view's hierarchy
        
        for subView in [self.NASAImageView, self.imageSearchBar, self.internetConnectionLabel, self.tryAgainButton, self.serverFailLabel, self.launchProgressView, self.imageCollection] {
            self.view.addSubview(subView)
        }
        
        // Configures subviews
        self.configureNASAImageView()
        self.configureFailureLabel(label: self.internetConnectionLabel, description: UIConstants.descriptionInternet)
        self.configureFailureLabel(label: self.serverFailLabel, description: UIConstants.descriptionServer)
        self.configureTryAgainButton()
        self.configureLaunchProgressView()
        
        // Adds constraints
        self.disableAutoresizingMasks()
        
        self.addConstraintsToNASAImageViewAtView()
        self.addConstraintsToNASAImageViewAndSearchBar()
        self.addConstraintsToSearchBarAtView()
        self.addConstraintsToCollectionAndSearchBar()
        self.addConstraintsToCollectionAtView()
        self.addConstraintsToFailureLabelAtView(self.internetConnectionLabel)
        self.addConstraintsToFailureLabelAtView(self.serverFailLabel)
        self.addConstraintToTryAgainButtonAtView()
        self.addConstraintsToProgressViewAtView()
        
        // Adds UI Actions
        self.tryAgainButton.addTarget(self, action: #selector(self.tryAgainButtonTapped(sender:)), for: .touchUpInside)
        self.imageSearchBar.delegate = self
        self.imageCollection.delegate = self
        
        // Starting UI state
        
        self.hideAllViewHierarchy()
        
        // Update Model
        
        images.addObserver(observer: self)
        images.fetchResults()
    }
    
    // MARK: - Combine Model&View Layers
    
    func adjustImageCollection() {
        self.imageCollection.register(ImageCollectionViewCell.self,
                                      forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        self.imageCollection.dataSource = self.imageDataSource
    }
    
    // MARK: - Configuring UI elements
    
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
    
    private func configureFailureLabel(label: UILabel, description: String) {
        let title = "Ooops!\n"
        
        guard let titleFont = UIFont(name: UIConstants.fontName, size: UIConstants.mainHeaderFontSize),
              let descriptionFont = UIFont(name: UIConstants.fontName, size: UIConstants.descriptionFontSize) else {
            return
        }
        
        let labelText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : titleFont,
                                                                              NSAttributedString.Key.foregroundColor : UIColor.white])
        labelText.append(NSAttributedString(string: description, attributes: [NSAttributedString.Key.font : descriptionFont,
                                                                              NSAttributedString.Key.foregroundColor : UIColor.white]))
        
        label.attributedText = labelText
        
        label.textAlignment = .center
        label.numberOfLines = 0
    }
    
    private func configureTryAgainButton() {
        let title = "Try Again!"
        guard let titleFont = UIFont(name: UIConstants.fontName, size: UIConstants.tryAgainTitleFontSize) else { return }
        let titleText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : titleFont,
                                                                              NSAttributedString.Key.foregroundColor : UIColor.white])
        self.tryAgainButton.setAttributedTitle(titleText, for: .normal)
        
        self.tryAgainButton.backgroundColor = .superViolet
        
        self.tryAgainButton.layer.borderWidth = UIConstants.tryAgainButtonBorderWidth
        self.tryAgainButton.layer.borderColor = UIColor.white.cgColor
        self.tryAgainButton.layer.cornerRadius = UIConstants.tryAgainButtonCornerRadius
    }
    
    private func configureLaunchProgressView() {
        self.launchProgressView.backgroundColor = .clear
        self.launchProgressView.hidesWhenStopped = true
        self.launchProgressView.style = .whiteLarge
    }
    
    // MARK: - Constraints
    
    func hideAllViewHierarchy() {
        self.view.subviews.forEach { sub in
            sub.isHidden = true
        }
    }
    
    func disableAutoresizingMasks() {
        self.view.subviews.forEach { sub in
            sub.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // Methods follows the visual view's hierarchy
    
    // MARK: - Main State's Views [Constraints]
    
    // NASA Image will be always visible
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
    
    // MARK: - Internet Connection State [Constraints] & Server Failed State [Constraints]
    
    // both labels [sever failure & internet connection failure]
    private func addConstraintsToFailureLabelAtView(_ label: UILabel) {
        guard let superView = label.superview else {
            return
        }
        
        label.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }
    
    private func addConstraintToTryAgainButtonAtView() {
        guard let superView = self.tryAgainButton.superview else {
            return
        }
        
        self.tryAgainButton.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -40.0).isActive = true
        self.tryAgainButton.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.tryAgainButton.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 0.5).isActive = true
        self.tryAgainButton.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    // MARK: - Loading Images State [Constraints]
    
    private func addConstraintsToProgressViewAtView() {
        guard let superView = self.launchProgressView.superview else {
            return
        }
        
        self.launchProgressView.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.launchProgressView.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }
}

extension ImageController {
    // MARK: UI Actions
    
    @objc func tryAgainButtonTapped(sender: UIButton) {
        //sender.pulsate()
        sender.flash()
        self.images.fetchResults()
    }
    
}

extension ImageController: ImagesObserver {
    
    // MARK: - Images' Observer Implementation
    
    // calls when:
    //   - app launches
    //   - user tries to load image's database after internet connection failure
    func didImagesStartLoading(_ images: Images) {
        self.hideAllViewHierarchy()
        self.NASAImageView.isHidden = false
        self.launchProgressView.isHidden = false
        self.launchProgressView.startAnimating()
    }
    
    // calls when:
    //   - loading fails because of the lack of internet connection
    func didNoInternetConnection(_ images: Images) {
        self.hideAllViewHierarchy()
        self.NASAImageView.isHidden = false
        self.internetConnectionLabel.isHidden = false
        self.tryAgainButton.isHidden = false
    }
    
    // calls when:
    //  - any error occurs at the time of request to NASA's Api
    func didNetworkingErrorOccured(_ images: Images, error: NetworkingError) {
        self.hideAllViewHierarchy()
        self.NASAImageView.isHidden = false
        self.serverFailLabel.isHidden = false
    }
    
    // calls when:
    //  - all images successfully recieved from the server
    func didImagesFinishLoading(_ images: Images, image: [Images.ImageModel]) {
        self.hideAllViewHierarchy()
        self.NASAImageView.isHidden = false
        self.imageSearchBar.isHidden = false
        self.imageCollection.isHidden = false
        
        self.imageDataSource = ImageDataSource(images: image)
        self.adjustImageCollection()
    }
}

// MARK: - UI Actions

extension ImageController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modelInfo = self.imageDataSource.fetchModelData(by: indexPath)
        let detailController = DetailController()
        
        detailController.passData(model: modelInfo.imageModel, image: modelInfo.image)
        self.present(detailController, animated: true)
    }
}

extension ImageController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.imageDataSource.update(images: self.images.images)
        } else {
            let filteredImages = self.images.images.filter { image in
                return image.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            self.imageDataSource.update(images: filteredImages)
        }
        
        self.imageCollection.reloadData()
    }
}

