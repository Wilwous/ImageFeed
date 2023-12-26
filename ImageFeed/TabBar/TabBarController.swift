//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Антон Павлов on 08.12.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func awakeFromNib() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let imagesListController = storyboard.instantiateViewController(
            withIdentifier: "ImagesListViewController")
        let profileViewController = ProfileViewController()
        profileViewController.configure(ProfileViewPresenter())
        profileViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tab_profile_active"),
            selectedImage: nil
        )
        self.viewControllers = [imagesListController, profileViewController]
    }
}
