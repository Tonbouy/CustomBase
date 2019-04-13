//
//  UIKit+Keyboard.swift
//  UIKit+Keyboard
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    var hideKeyboardOnClickEnabled: Bool {
        set {
            if newValue {
                if getHideKeyboardGesture() == nil {
                    let closeKeyboardGesture = CloseKeyboardGesture(target: self, action: #selector(self.closeKeyboard))
                    view.addGestureRecognizer(closeKeyboardGesture)
                }
            } else {
                _ = view.gestureRecognizers?.filter { !isHideKeyboardGesture($0) }
            }
        }
        get {
            return getHideKeyboardGesture() != nil
        }
    }
    
    private func getHideKeyboardGesture() -> UIGestureRecognizer? {
        return view.gestureRecognizers?.first(where: { gesture -> Bool in
            return isHideKeyboardGesture(gesture)
        })
    }
    
    private func isHideKeyboardGesture(_ gesture: UIGestureRecognizer) -> Bool {
        return gesture is CloseKeyboardGesture
    }
    
    @objc func closeKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
}

public extension UITextField {
    
    func addToolbarToNumberPad() {
        let numberPadToolbar: UIToolbar = UIToolbar()
        
        numberPadToolbar.isTranslucent = true
        numberPadToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .cancel, target: self,
                            action: #selector(self.cancelAction)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            //            UIBarButtonItem(title: "Custom", style: .done, target: self, action: #selector(self.customAction(textField:textField))),
            UIBarButtonItem(barButtonSystemItem: .done, target: self,
                            action: #selector(self.doneAction))
        ]
        
        numberPadToolbar.sizeToFit()
        self.inputAccessoryView = numberPadToolbar
    }
    
    @objc func cancelAction(_ sender: Any?) {
        self.resignFirstResponder()
    }
    
    @objc func customAction(_ sender: Any?) {
        self.resignFirstResponder()
    }
    
    @objc func doneAction(_ sender: Any?) {
        sendActions(for: .editingDidEndOnExit)
        self.resignFirstResponder()
    }
}

class CloseKeyboardGesture: UITapGestureRecognizer { }
