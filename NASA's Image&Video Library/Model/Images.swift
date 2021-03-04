//
//  Image.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 02/03/2021.
//

import Foundation

// Defines model and its behaviour (by state's enum)
// - Load itself from NASA's API
// - Supports observing by implementation observing pattern
// - Pass model's data to the Collection Scene Controller


// MARK: - Model's Definition

class Images {
    struct ImageModel {
        let id: UInt
        let imageURL: URL
        let title: String
        let location: String?
        let description: String?
        let photographer: String?
    }
    
    private var observations = [ObjectIdentifier : Observation]()
    
    fileprivate var state = State.initialized {
        didSet {
            self.stateDidChange()
        }
    }
    
    private(set) var images: [ImageModel] = []
}

// MARK: - Model's States

private extension Images {
    enum State {
        case initialized
        case startLoading
        case internetConnection
        case requestError(error: NetworkingError)
        case finishLoading(images: [ImageModel])
    }
    
    func stateDidChange() {
        for (id, observation) in observations {
            guard let observer = observation.observer else {
                observations.removeValue(forKey: id)
                continue
            }
            
            switch self.state {
            case .startLoading:
                observer.didImagesStartLoading(self)
            case .internetConnection:
                observer.didNoInternetConnection(self)
            case .requestError(let err):
                observer.didNetworkingErrorOccured(self, error: err)
            case .finishLoading(let images):
                observer.didImagesFinishLoading(self, image: images)
            default:
                break
            }
        }
        
    }
}

// MARK: - Observation's support

private extension Images {
    struct Observation {
        weak var observer: ImagesObserver?
    }
}

extension Images {
    func addObserver(observer: ImagesObserver) {
        let id = ObjectIdentifier(observer)
        self.observations.updateValue(Observation(observer: observer), forKey: id)
    }
    
    func removeObserver(observer: ImagesObserver) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }
}

// MARK: - Load Data From API

extension Images {
    func fetchResults() {
        self.state = .startLoading
        
        DispatchQueue.global(qos: .utility).async { [weak self] in
            let fetchDataGroup = DispatchGroup()
            
            let url = Endpoint.fetchImages().url
            var requestResult: Result<Data, NetworkingError> = .success(Data())
            
            // Tries to fetch data with http-request
            fetchDataGroup.enter()
            URLSession.shared.sendRequest(with: url) { res in
                switch res {
                case .failure(let err):
                    requestResult = .failure(err)
                case .success(let data):
                    requestResult = .success(data)
                }
                fetchDataGroup.leave()
            }
            
            // wait till request is completed
            fetchDataGroup.wait()
            
            // if request failed changes model's state and immediately returns
            var fetchedData = Data()
            
            do {
                fetchedData = try requestResult.get()
            } catch {
                DispatchQueue.main.async {
                    self?.setStateBased(on: (error as! NetworkingError))
                }
                return
            }
            
            // if decoding fails changes model's state and immediately returns
            
            guard let fetchedImagesInfo = try? JSONDecoder().decode(Collection.self, from: fetchedData) else {
                DispatchQueue.main.async {
                    self?.setStateBased(on: .DataError)
                }
                return
            }
            
            // map decoded object to the model
            guard let images: [ImageModel] = self?.map(fetchedImagesInfo) else {
                return
            }
            
            DispatchQueue.main.async {
                self?.images = images
                self?.state = .finishLoading(images: images)
            }
        }
    }
    
    
    private func setStateBased(on error: NetworkingError) {
        if error == .InternetConnectionError {
            self.state = .internetConnection
        } else {
            self.state = .requestError(error: error)
        }
    }
    
    private func map(_ from: Collection) -> [ImageModel] {
        let images = from.collection.images
        var imageModels: [ImageModel] = []
        
        for (index, image) in images.enumerated() {
            imageModels.append(ImageModel(id: UInt(index),
                                          imageURL: image.resources[0].imageURL,
                                          title: image.data[0].title,
                                          location: image.data[0].location,
                                          description: image.data[0].description,
                                          photographer: image.data[0].photographer))
        }
        
        return imageModels
    }
}
