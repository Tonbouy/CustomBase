//
//  BaseGradient.swift
//  BaseGradient
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
open class BaseGradient: UIView {

    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            clipsToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable
    public var startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0)

    @IBInspectable
    public var endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)

    @IBInspectable
    public var startColor: UIColor = UIColor.white

    @IBInspectable
    public var middleColor: UIColor?

    @IBInspectable
    public var endColor: UIColor = UIColor.black
    public let gradientLayer = CAGradientLayer()

    public func updateGradient() {
        if let middleColor = self.middleColor {
            gradientLayer.colors = [self.startColor.cgColor, middleColor.cgColor, self.endColor.cgColor]
        } else {
            gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
        }
        gradientLayer.startPoint = self.startPoint
        gradientLayer.endPoint = self.endPoint
        gradientLayer.frame = self.bounds

        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        updateGradient()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateGradient()
    }
}
