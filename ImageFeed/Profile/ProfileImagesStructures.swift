//
//  ProfileImagesStructures.swift
//  ImageFeed
//
//  Created by Антон Павлов on 30.11.2023.
//

import Foundation

struct UserResult: Codable {
    let profileImage: ProfileImage?
}

struct ProfileImage: Codable {
    let small: String?
    let medium: String?
    let large: String?
}
