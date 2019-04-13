//
//  GradientProgressView.swift
//  GradientProgressView
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    convenience init(view: UIView) {

        UIGraphicsBeginImageContext(view.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                if let cgImage = image.cgImage {
                    self.init(cgImage: cgImage)
                } else {
                    self.init()
                }
            } else {
                self.init()
            }
        } else {
            self.init()
        }
    }
}
