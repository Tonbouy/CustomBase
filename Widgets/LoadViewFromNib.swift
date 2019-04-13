//
//  LoadViewFromNib.swift
//  LoadViewFromNib
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import UIKit

public protocol LoadViewFromNib {
    
    func loadViewFromNib(withAutoSize: Bool) -> UIView
    
    var nibName: String { get }
}

public extension LoadViewFromNib where Self: UIView {
    
    func loadViewFromNib(withAutoSize: Bool = true) -> UIView {
        let bundle = Bundle(for: type(of: self) as AnyClass)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView //swiftlint:disable:this force_cast
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        return view
    }
    
}
