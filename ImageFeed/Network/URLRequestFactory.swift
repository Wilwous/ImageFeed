//
//  URLRequestFactory.swift
//  ImageFeed
//
//  Created by Антон Павлов on 14.10.2023.
//

import Foundation

final class URLRequestFactory {
    
    static let shared = URLRequestFactory()
    
    private let storage = OAuth2TokenStorage.shared
    
    private init() {}
    
    // MARK: - HTTP Request
    func makeHTTPRequest(
        path: String,
        httpMethod: String,
        baseURLString: String = Constants.defaultApiBaseURLString
    ) -> URLRequest? {
        guard
            let url = URL(string: baseURLString),
            let baseURL = URL(string: path, relativeTo: url)
        else { return nil }
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = httpMethod
        
        if let token = storage.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
