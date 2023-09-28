//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by Антон Павлов on 28.09.2023.
//

import UIKit
import WebKit

final class WebViewViewController: UIViewController{
    
    @IBOutlet private weak var webView: WKWebView!
    
    @IBAction func didTapBackButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        let UnsplashAuthorizeURLString = "https://unsplash.com/oauth/token"
        var urlComponents = URLComponents(string: UnsplashAuthorizeURLString)!
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: AccessKey),
            URLQueryItem(name: "redirect_uri", value: RedirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: AccessScope)
        ]
        let url = urlComponents.url!
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
