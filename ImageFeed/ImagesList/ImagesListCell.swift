//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Антон Павлов on 02.08.2023.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    // MARK: - Constants
    
    static let reuseIdentifier = "ImagesListCell"
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var cellImage: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var dateLabel: UILabel!
}

// MARK: - Public Functions

extension ImagesListCell {
    
    func configCell(image: UIImage?, date: String, isLiked: Bool) {
        
        let likeImage = isLiked ? UIImage(named: "like_button_on") : UIImage(named: "like_button_off")
        
        cellImage.image = image
        dateLabel.text = date
        likeButton.setImage(likeImage, for: .normal)
    }
}

