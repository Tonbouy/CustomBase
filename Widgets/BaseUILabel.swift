//
//  BaseUILabel.swift
//  BaseUILabel
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import UIKit

///
/// Icon horizontal position toward text
///
public enum BaseUILabelHorizontalPosition {
    case left
    case right
}

///
/// Icon vertical position
///
public enum BaseUILabelVerticalPosition {
    case top
    case center
    case bottom
}

public typealias BaseUILabelIconPosition = (horizontal: BaseUILabelHorizontalPosition, vertical: BaseUILabelVerticalPosition)

@IBDesignable
open class BaseUILabel: UILabel {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            clipsToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    public var horizontalTextInset: CGFloat {
        set {
            textInsets.left = newValue
            textInsets.right = newValue
        }
        get { return textInsets.left }
    }
    
    @IBInspectable
    public var verticalTextInset: CGFloat {
        set {
            textInsets.top = newValue
            textInsets.bottom = newValue
        }
        get { return textInsets.top }
    }
    
    public var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    /// Image that will be placed with a text
    open var icon: UIImage? {
        didSet {
            if icon == nil {
                iconView?.removeFromSuperview()
            }
            setNeedsDisplay()
        }
    }

    public var tintIconLikeText: Bool = false

    /// Position of an image
    open var iconPosition: BaseUILabelIconPosition = ( .left, .top )

    /// Additional spacing between text and image
    open var iconPadding: CGFloat = 0

    // MARK: Privates

    public var iconView: UIImageView?

    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }

    // MARK: Custom text drawings
    open override func drawText(in rect: CGRect) { //swiftlint:disable:this cyclomatic_complexity
        guard let text = self.text as NSString? else { return }
        guard let icon = icon else {
            super.drawText(in: rect.inset(by: textInsets))
            return
        }

        iconView?.removeFromSuperview()
        iconView = UIImageView(image: icon)
        if self.tintIconLikeText {
            iconView?.tintColor = self.textColor
        }

        var newRect = CGRect.zero
        guard let font = font else { return }
        let size = text.boundingRect(with: CGSize(width: frame.width - icon.size.width - iconPadding, height: CGFloat.greatestFiniteMagnitude),
                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                     attributes: [ NSAttributedString.Key.font: font ],
                                     context: nil).size

        guard let iconView = iconView else { return }
        let iconYPosition = (frame.height - iconView.frame.height) / 2
        let height = frame.height

        if iconPosition.horizontal == .left {
            if textAlignment == .left {
                iconView.frame = iconView.frame.offsetBy(dx: 0, dy: iconYPosition)
                newRect = CGRect(x: iconView.frame.width + iconPadding, y: 0, width: frame.width - (iconView.frame.width + iconPadding), height: height)
            } else if textAlignment == .right {
                iconView.frame = iconView.frame.offsetBy(dx: frame.width - size.width - iconView.frame.width - iconPadding, dy: iconYPosition)
                newRect = CGRect(x: frame.width - size.width - iconPadding, y: 0, width: size.width + iconPadding, height: height)
            } else if textAlignment == .center {
                iconView.frame = iconView.frame.offsetBy(dx: (frame.width - size.width) / 2 - iconPadding - iconView.frame.width, dy: iconYPosition)
                newRect = CGRect(x: (frame.width - size.width) / 2, y: 0, width: size.width + iconPadding, height: height)
            }
        } else if iconPosition.horizontal == .right {
            if textAlignment == .left {
                iconView.frame = iconView.frame.offsetBy(dx: size.width + iconPadding, dy: iconYPosition)
                newRect = CGRect(x: 0, y: 0, width: size.width, height: height)
            } else if textAlignment == .right {
                iconView.frame = iconView.frame.offsetBy(dx: frame.width - iconView.frame.width, dy: iconYPosition)
                newRect = CGRect(x: frame.width - size.width - iconView.frame.width - iconPadding, y: 0, width: size.width, height: height)
            } else if textAlignment == .center {
                iconView.frame = iconView.frame.offsetBy(dx: frame.width / 2 + size.width / 2 + iconPadding, dy: iconYPosition)
                newRect = CGRect(x: (frame.width - size.width) / 2, y: 0, width: size.width, height: height)
            }
        }

        switch iconPosition.vertical {
        case .top:
            iconView.frame.origin.y = (frame.height - size.height) / 2

        case .center:
            iconView.frame.origin.y = (frame.height - iconView.frame.height) / 2

        case .bottom:
            iconView.frame.origin.y = frame.height - (frame.height - size.height) / 2 - iconView.frame.size.height
        }

        addSubview(iconView)
        super.drawText(in: newRect)
    }
}
