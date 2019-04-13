//
//  UIView+iOSBorder.swift
//  UIView+iOSBorder
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import UIKit

public extension UIView {
    func setupiOSBorder() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 0.86, green: 0.85, blue: 0.83, alpha: 1).cgColor
    }
}
