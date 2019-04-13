//
//  UINavigation+Extensions.swift
//  UINavigation+Extensions
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import UIKit

public extension UINavigationController {

    func makeTranslucent(tintColor: Color) {
        makeTranslucent(tintColor: tintColor.value)
    }

    func makeTranslucent(tintColor: UIColor) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tintColor
        navigationBar.titleTextAttributes = [.foregroundColor: tintColor, .font: UIFont(name: "Aileron-Bold", size: 17) as Any]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    func change(tint tintColor: UIColor) {
        navigationBar.barTintColor = tintColor
        navigationBar.tintColor = tintColor
        navigationBar.titleTextAttributes = [.foregroundColor: tintColor, .font: UIFont(name: "Aileron-Bold", size: 17) as Any]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    func tint(color: Color, controlColor: Color) {
        tint(color: color.value, controlColor: controlColor.value)
    }

    func tint(color: UIColor, controlColor: UIColor) {
        navigationBar.barTintColor = color
        navigationBar.isTranslucent = false
        navigationBar.tintColor = controlColor
        navigationBar.titleTextAttributes = [.foregroundColor: controlColor, .font: UIFont(name: "Aileron-Bold", size: 17) as Any]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
