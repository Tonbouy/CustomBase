//
//  BaseUIButton.swift
//  BaseUIButton
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable
open class BaseUIButton: UIButton {

    public static let HEIGHT: CGFloat = 44
 
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            clipsToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    public var horizontalInset: CGFloat = 12 {
        didSet {
            contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        }
    }
    @IBInspectable
    public var verticalInset: CGFloat = 8 {
        didSet {
            contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        }
    }

    @IBInspectable
    public var titleColorName: String? {
        didSet {
            self.setTitleColor(NamedColor.get(withName: titleColorName), for: .normal)
        }
    }

    @IBInspectable
    public var indicatorColorName: UIColor = UIColor.white
    
    public var indicatorColor: UIColor = .white
    public var originalButtonText: String?
    public var activityIndicator: UIActivityIndicatorView!
    public var isLoading = false
    private var wasEnabled: Bool?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
    
    public func loading(_ loading: Bool) {
        if loading {
            showLoading()
            wasEnabled = isEnabled
            isEnabled = false
        } else {
            hideLoading()
            if let wasEnabled = wasEnabled {
                isEnabled = wasEnabled
            }
        }
        isLoading = loading
    }
    
    private func showLoading() {
        if isLoading {
            return
        }
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        showSpinning()
    }
    
    private func hideLoading() {
        if originalButtonText == nil || activityIndicator == nil || !isLoading {
            return
        }
        self.setTitle(self.originalButtonText, for: .normal)
        self.activityIndicator.stopAnimating()
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = indicatorColor
        return activityIndicator
    }
    
    private func showSpinning() {
        if activityIndicator == nil {
            activityIndicator = createActivityIndicator()
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(activityIndicator)
            centerActivityIndicatorInButton()
        }
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
    open override func backgroundRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset, dy: verticalInset)
    }
}

public extension Reactive where Base: BaseUIButton {
    
    /// Bindable sink for `loading` property.
    var isLoading: Binder<Bool> {
        return Binder(self.base) { element, value in
            element.loading(value)
        }
    }
}
