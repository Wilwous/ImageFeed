//
//  UIBlockingProgressHUD.swift
//  ImageFeed
//
//  Created by Антон Павлов on 10.10.2023.
//

import UIKit
import ProgressHUD

final class UIBlockingProgressHUD {
    static var isShowing: Bool = false
    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.show()
    }
    
    
    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}

