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
    
    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: Constants.bearerToken)
        }
        set {
            if let token = newValue {
                KeychainWrapper.standard.set(token, forKey: Constants.bearerToken)
            } else {
                KeychainWrapper.standard.removeObject(forKey: Constants.bearerToken)
            }
        }
    }
}

extension OAuth2TokenStorage {
    func clean() {
        keychain.removeAllKeys()
    }
}
