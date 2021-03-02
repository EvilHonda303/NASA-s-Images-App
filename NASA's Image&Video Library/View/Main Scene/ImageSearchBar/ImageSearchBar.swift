//
//  ImageSearchBar.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 02/03/2021.
//

import UIKit

final class ImageSearchBar: UISearchBar {
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        self.configure()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Search Bar Configuration
    func configure() {
        self.placeholder = "Search Images"
        self.tintColor = .black
        self.searchBarStyle = .minimal
        self.isTranslucent = false
        
        // Customizes searchField's color, text and etc
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = .white
        }
        
        // Text Input Traits
        self.returnKeyType = .search
        
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.autocapitalizationType = .none
        
        
        self.showsSearchResultsButton = true
    }
}
