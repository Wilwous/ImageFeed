//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Антон Павлов on 02.08.2023.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
    static let reuseIdentifier = "ImagesListCell"
}
