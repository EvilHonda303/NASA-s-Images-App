//
//  URLSession+Extension.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 02/03/2021.
//

import Foundation

extension URLSession {
    func sendRequest(with url: URL, completionHandler: @escaping (Result<Data, NetworkingError>) -> ()) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let err = (error as NSError?) {
                    if err.domain == NSURLErrorDomain {
                        completionHandler(.failure(.InternetConnectionError))
                    } else {
                        completionHandler(.failure(.ServerError))
                    }
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                     (200...299).contains(httpResponse.statusCode) else {
                      completionHandler(.failure(.ResponseError))
                      return
                }
                
                guard let data = data else {
                    completionHandler(.failure(.DataError))
                    return
                }
                
                
                return completionHandler(.success(data))
            }.resume()
        }

}
