//
//  File.swift
//  ImageFeed
//
//  Created by Антон Павлов on 27.12.2023.
//

import Foundation

struct Profile {
    let username: String
    let name: String
    let loginName: String
    let bio: String?
    
    init(result profileResult: ProfileResult) {
        self.username = profileResult.userName ?? ""
        self.name = "\(profileResult.firstName ?? "") \(profileResult.lastName ?? "")"
        self.loginName = "@" + self.username
        self.bio = profileResult.bio
    }
}
