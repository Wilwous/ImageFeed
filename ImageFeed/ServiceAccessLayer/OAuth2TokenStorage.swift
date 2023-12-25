//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Антон Павлов on 30.09.2023.
//

import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    
    static let shared = OAuth2TokenStorage()
    private let keychain = KeychainWrapper.standard
    
    private init() {}
    
    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: "bearerToken")
        }
        set {
            if let token = newValue {
                KeychainWrapper.standard.set(token, forKey: "bearerToken")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "bearerToken")
            }
        }
    }
}

extension OAuth2TokenStorage {
    func clean() {
        keychain.removeAllKeys()
    }
}
