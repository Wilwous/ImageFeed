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
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Public Functions
    
    func setIsLiked(entryValue: Bool) {
        let image = entryValue ? UIImage(named: "Like_button_active") : UIImage(named: "Like_button_inactive")
        likeButton.setImage(image, for: .normal)
    }
}

