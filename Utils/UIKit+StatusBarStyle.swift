//
//  UIKit+StatusBarStyle.swift
//  UIKit+StatusBarStyle
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return selectedViewController?.preferredStatusBarStyle ?? .lightContent
    }

    override open var childForStatusBarStyle: UIViewController? {
        return selectedViewController
    }
}

extension UINavigationController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return visibleViewController?.preferredStatusBarStyle ?? .lightContent
    }

    override open var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
}
