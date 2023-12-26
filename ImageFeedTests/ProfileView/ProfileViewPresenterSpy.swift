//
//  File.swift
//  ImageFeedTests
//
//  Created by Антон Павлов on 26.12.2023.
//

import UIKit
@testable import ImageFeed

final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol {

    var view: ImageFeed.ProfileViewControllerProtocol?
    private let profileService = ProfileService.shared
    var profileData = Profile(result: ProfileResult(userName: "testNickname",
                                                     firstName: "test1stName",
                                                     lastName: "test2ndName",
                                                     bio: "aboutMe"))
    var viewDidLoadCalled = false
    var profileImageCheck = false
    var logoutCheck = false
    
    func profileImageObserver() {
        viewDidLoadCalled = true
    }
    
    func prepareAlert() -> (title: String, message: String, actionYes: String, actionNo: String) {
        return ("AlertTitle", "AlertMessage", "Yes", "No")
    }
    
    func getProfileImageURL() -> URL? {
        profileImageCheck = true
        return nil
    }
    
    func getProfileDetails() -> ImageFeed.Profile? {
        let profile = profileData
        return profile
    }
    
    func cleanAndSwitchToSplashView() {
        logoutCheck = true
    }
    
}

