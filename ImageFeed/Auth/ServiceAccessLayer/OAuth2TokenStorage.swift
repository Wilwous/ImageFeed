//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Антон Павлов on 30.09.2023.
//

import Foundation

final class OAuth2TokenStorage {
    
    static let shared = OAuth2TokenStorage()
    
    private enum Keys: String {
        case token
    }
    
    var token: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.token.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.token.rawValue)
        }
    }
}
