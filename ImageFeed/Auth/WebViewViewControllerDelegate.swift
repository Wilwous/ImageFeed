//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Антон Павлов on 28.09.2023.
//

import Foundation

// MARK: - WebViewViewControllerDelegate

protocol WebViewViewControllerDelegate: AnyObject{
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}
