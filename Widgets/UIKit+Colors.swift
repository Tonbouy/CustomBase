//
//  UIKit+Colors.swift
//  UIKit+Colors
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public extension UIView {
    
    @IBInspectable
    var backgroundColorName: String? {
        get { return nil }
        set {
            backgroundColor = NamedColor.get(withName: newValue)
        }
    }
    
    @IBInspectable
    var tintColorName: String? {
        get { return nil }
        set {
            tintColor = NamedColor.get(withName: newValue)
        }
    }
}

public extension UILabel {
    
    @IBInspectable
    var textColorName: String? {
        get { return nil }
        set {
            textColor = NamedColor.get(withName: newValue)
        }
    }
    
    @IBInspectable
    var highLightedTextColorName: String? {
        get { return nil }
        set {
            highlightedTextColor = NamedColor.get(withName: newValue)
        }
    }
    
    @IBInspectable
    var shadowColorName: String? {
        get { return nil }
        set {
            shadowColor = NamedColor.get(withName: newValue)
        }
    }
}

public extension UITextView {
    
    @IBInspectable
    var textColorName: String? {
        get { return nil }
        set {
            self.textColor = NamedColor.get(withName: newValue)
        }
    }
}

public extension UITextField {
    
    @IBInspectable
    var textColorName: String? {
        get { return nil }
        set {
            textColor = NamedColor.get(withName: newValue)
        }
    }
}

public extension UIButton {

}
