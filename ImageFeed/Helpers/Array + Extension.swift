//
//  Array + Extension.swift
//  ImageFeed
//
//  Created by Антон Павлов on 19.12.2023.
//

import Foundation

extension Array {
    func withReplaced(itemAt: Int, newValue: Photo) -> [Photo] {
        var photos = ImagesListService.shared.photos
        photos.replaceSubrange(itemAt...itemAt, with: [newValue])
        return photos
    }
}
