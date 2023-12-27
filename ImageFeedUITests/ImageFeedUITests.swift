//
//  ImageFeedUITests.swift
//  ImageFeedUITests
//
//  Created by Антон Павлов on 26.12.2023.
//

import XCTest

final class ImageFeedUITests: XCTestCase {
    
    private let app = XCUIApplication()
    
    let login = "hesher.tm@gmail.com"
    let password = "HESHERahamo2012"
    let username = "Anton Pavlov"
    let nickname = "@wilwous"
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testAuth() throws {
        app.buttons["Authenticate"].tap()
        
        let webView = app.webViews["UnsplashWebView"]
        XCTAssertTrue(webView.waitForExistence(timeout: 3))
        
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 4))
        loginTextField.tap()
        loginTextField.typeText(login)
        sleep(4)
        webView.swipeUp()
        app.toolbars.buttons["Done"].tap()
        
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 4))
        passwordTextField.tap()
        
        passwordTextField.typeText(password)
        sleep(5)
        
        webView.buttons["Login"].tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        sleep(5)
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
    }
    
    func testFeed() throws {
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        cell.swipeUp()
        
        sleep(2)
        
        let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)
        let likeButton = cellToLike.buttons["LikeButton"]
        likeButton.tap()
        sleep(2)
        likeButton.tap()
        sleep(2)
        
        cellToLike.tap()
        sleep(2)
        
        let image = app.scrollViews.images.element(boundBy: 0)
        image.pinch(withScale: 3, velocity: 1)
        image.pinch(withScale: 0.5, velocity: -1)
        
        let navBackButton = app.buttons["navBackButton"]
        navBackButton.tap()
    }
    
    func testProfile() throws {
        sleep(1)
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        XCTAssertTrue(app.staticTexts[username].exists)
        XCTAssertTrue(app.staticTexts[nickname].exists)
        
        app.buttons["logoutButton"].tap()
        
        sleep(2)
        app.alerts["Oй все, пока!"].scrollViews.otherElements.buttons["Да"].tap()
        
        sleep(3)
        XCTAssertTrue(app.buttons["Authenticate"].exists)
    }
    
}
