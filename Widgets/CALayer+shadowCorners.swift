//
//  CALayer+shadowCorners.swift
//  CALayer+shadowCorners
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import UIKit

extension CALayer {
    private func addShadowWithRoundedCorners() {
        if let contents = self.contents {
            masksToBounds = false

            sublayers?.filter { $0.frame.equalTo(self.bounds) }
                .forEach { $0.roundCorners(radius: self.cornerRadius) }

            self.contents = nil

            if let sublayer = sublayers?.first,
                sublayer.name == "UICore:ContentLayer" {
                sublayer.removeFromSuperlayer()
            }

            let contentLayer = CALayer()

            contentLayer.name = "UICore:ContentLayer"
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true

            insertSublayer(contentLayer, at: 0)
        }
    }

    func addShadow(withOpacity opacity: Float = 0.2) {
        self.shadowOffset = .zero
        self.shadowOpacity = opacity
        self.shadowRadius = 10
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
        if shadowOpacity != 0 {
            addShadowWithRoundedCorners()
        }
    }
}
