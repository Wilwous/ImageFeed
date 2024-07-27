//
//  ProfileViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Антон Павлов on 26.12.2023.
//

import UIKit
@testable import ImageFeed

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    
    var presenter: ImageFeed.ProfileViewPresenterProtocol?
    var alertCheck = false
    var presenterSpy = ProfileViewPresenterSpy()
    
    func switchToSplashScreen() {}
    
    func updateAvatar() {}
    
    func showAlert() {
        let input = presenterSpy.prepareAlert()
        
        let alert = UIAlertController(title: input.title, message: input.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: input.actionYes, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: input.actionNo, style: .default, handler: nil))
        alertCheck = true
    }
}
