//
//  URLRequestFactory.swift
//  ImageFeed
//
//  Created by Антон Павлов on 14.10.2023.
//

import Foundation

final class URLRequestFactory {
    
    static let shared = URLRequestFactory()
    
    private let storage: OAuth2TokenStorage
    
    init(storage: OAuth2TokenStorage = .shared) {
        self.storage = storage
    }
    
    // MARK: - HTTP Request
    func makeHTTPRequest(
        urlString: String,
        parameters: [String: String],
        httpMethod: String
    ) -> URLRequest {
        var urlComponents = URLComponents(string: urlString)
        var queryItems: [URLQueryItem] = []
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents?.queryItems = queryItems
        
        var request = URLRequest(url: urlComponents!.url!)
        request.httpMethod = httpMethod
        return request
    }
}
