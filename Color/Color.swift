//
//  Color.swift
//  Color
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import UIKit

public protocol Color {
    var value: UIColor { get }
    var name: String { get }
    
    static func with(name: String) -> Self?
}

public struct NamedColor {
    
    public static var colors = [String: UIColor]()

    public static func putColors(_ colors: [Color]) {
        colors.forEach {
            self.colors[$0.name] = $0.value
        }
    }

    public static func putColors(_ colors: [(String, UIColor)]) {
        colors.forEach { (key, color) in
            self.colors[key] = color
        }
    }

    public static func putColors(_ colors: [String: UIColor]) {
        colors.forEach { (key, color) in
            self.colors[key] = color
        }
    }

    public static func addColor(name: String, color: UIColor) {
        self.colors[name] = color
    }

    public static func get(withName name: String?) -> UIColor? {
        if let name = name {
            return colors[name]
        } else {
            return nil
        }
    }
}
