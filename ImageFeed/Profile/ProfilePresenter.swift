//
//  ProfilePresenter.swift
//  ImageFeed
//
//  Created by Антон Павлов on 26.12.2023.
//

import Foundation

protocol ProfileViewPresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func profileImageObserver()
    func prepareAlert() -> (title: String, message: String, actionYes: String, actionNo: String)
    func getProfileImageURL() -> URL?
    func getProfileDetails() -> Profile?
    func cleanAndSwitchToSplashView()
}

final class ProfileViewPresenter: ProfileViewPresenterProtocol {
    
    weak var view: ProfileViewControllerProtocol?
    
    private let imagesListService = ImagesListService.shared
    private let profileImageService = ProfileImageService.shared
    private let profileService = ProfileService.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    private let token = OAuth2TokenStorage.shared
    
    func profileImageObserver() {
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                view?.updateAvatar()
            }
    }
    
    func getProfileImageURL() -> URL? {
        guard let profileImageURL = profileImageService.avatarURL,
              let url = URL(string: profileImageURL)
        else { return nil }
        return url
    }
    
    func getProfileDetails() -> Profile? {
        guard let profile = profileService.profile else { return nil }
        return profile
    }
    
    func prepareAlert() -> (title: String, message: String, actionYes: String, actionNo: String) {
        let title = "Oй все, пока!"
        let message = "Тебе лишь бы уйти, да?!"
        let actionYes = "Да"
        let actionNo = "Нет"
        return (title, message, actionYes, actionNo)
    }
    
    func cleanAndSwitchToSplashView() {
        WebViewViewController.clean()
        profileImageService.clean()
        profileService.clean()
        imagesListService.clean()
        token.clean()
        
        view?.switchToSplashScreen()
    }   
}
