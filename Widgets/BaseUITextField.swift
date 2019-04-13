//
//  BaseUITextField.swift
//  BaseUITextField
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable
open class BaseUITextField: UITextField {
    
    @IBInspectable
    open var cornerRadius: CGFloat = 0.0 {
        didSet {
            clipsToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    open var horizontalTextInset: CGFloat = 15
    
    @IBInspectable
    open var verticalTextInset: CGFloat = 8
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalTextInset, dy: verticalTextInset)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalTextInset, dy: verticalTextInset)
    }
}

extension BaseUITextField {
    public func resignWhenFinished(_ disposeBag: DisposeBag, completionHandler: (() -> Void)? = nil) {
        setNextResponder(nil, disposeBag: disposeBag, completionHandler: completionHandler)
    }

    public func setNextResponder(_ nextResponder: UIResponder?, disposeBag: DisposeBag,
                                 completionHandler: (() -> Void)? = nil) {
        // Subscribe on editing end on exit control event
        rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self, weak nextResponder] in
                if let callback = completionHandler {
                    callback()
                }
                if let nextResponder = nextResponder {
                    nextResponder.becomeFirstResponder()
                } else {
                    self?.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
    }
}
