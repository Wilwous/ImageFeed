//
//  Constants.swift
//  ImageFeed
//
//  Created by Антон Павлов on 26.09.2023.
//

import Foundation

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultApiBaseURLString: String
    let unsplashAuthorizeURLString: String
    
    static var standard: AuthConfiguration {
        return AuthConfiguration(accessKey: "ItpF13R0bOeRoXFlT7lruRbTWWiXzJmUyMqSy4Q0PZQ",
                                 secretKey: "30zLrz2Of4ZGV2V4pV1KwdPQajmoxFYoUZ9n4Pvi6QA",
                                 redirectURI: "urn:ietf:wg:oauth:2.0:oob",
                                 accessScope: "public+read_user+write_likes",
                                 defaultApiBaseURLString: ("https://api.unsplash.com"),
                                 unsplashAuthorizeURLString: "https://unsplash.com/oauth/authorize")
    }
}
