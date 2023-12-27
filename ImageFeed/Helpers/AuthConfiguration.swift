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
        return AuthConfiguration(accessKey: "tb9ZdKHYwxdzp-Nb-5h1HmXV3Z2GBL_EWPrTqF-Iljo",
                                 secretKey: "yFGAWglfcgv9UuLUtzisba5nYTU0XyCEyu78Yru7N6M",
                                 redirectURI: "urn:ietf:wg:oauth:2.0:oob",
                                 accessScope: "public+read_user+write_likes",
                                 defaultApiBaseURLString: ("https://api.unsplash.com"),
                                 unsplashAuthorizeURLString: "https://unsplash.com/oauth/authorize")
    }
}
