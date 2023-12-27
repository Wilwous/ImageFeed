//
//  File.swift
//  ImageFeedTests
//
//  Created by Антон Павлов on 26.12.2023.
//

import XCTest
@testable import ImageFeed

final class ProfileViewTests: XCTestCase {

    func testViewControllerCallsViewDidLoad() {
        //given
        let vc = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        _ = vc.view
        
        //then
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testShowAlertCheck() {
        //given
        let view = ProfileViewControllerSpy()
        let presenter = ProfileViewPresenterSpy()
        view.presenter = presenter
        presenter.view = view
        
        //when
        view.showAlert()
        
        //then
        XCTAssertTrue(view.alertCheck)
    }
    
    func testLogout() {
        //given
        let token = OAuth2TokenStorage()
        let vc = ProfileViewController()
        let spy = ProfileViewPresenterSpy()
        let presenter = ProfileViewPresenter()
        vc.configure(presenter)
        
        //when
        spy.cleanAndSwitchToSplashView()
        presenter.cleanAndSwitchToSplashView()
        
        //then
        XCTAssertEqual(token.token, nil)
        XCTAssertTrue(spy.logoutCheck)
    }
    
    func testProfileDetails() {
        //given
        let vc = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        guard let profile = presenter.getProfileDetails() else { return }
        
        //then
        XCTAssertEqual(profile.username, "testNickname")
        XCTAssertEqual(profile.loginName, "@testNickname")
    }
    
    func testGetImageURL() {
        //given
        let vc = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let imageUrl = presenter.getProfileImageURL()
        
        //then
        XCTAssertTrue(presenter.profileImageCheck)
    }

}
