//
//  File.swift
//  ImageFeed
//
//  Created by Антон Павлов on 18.12.2023.
//

import UIKit

protocol ImagesListCellDelegate: AnyObject {
    func imagesListCellDidTapLike(_ cell: ImagesListCell)
}
