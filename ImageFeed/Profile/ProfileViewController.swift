//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Антон Павлов on 11.09.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var loginNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var logoutButton: UIButton!
    
    @IBAction private func didTapLogoutButton() {
    }
}
