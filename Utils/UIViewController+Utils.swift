//
//  UIViewController+Utils.swift
//  UIViewController+Utils
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import UIKit

extension UIViewController {
    @discardableResult
    public func showDialog(title: String,
                           message: String,
                           okBtn: String? = NSLocalizedString("Oui", comment: "le bouton ok par défaut dans une popup"),
                           cancelBtn: String? = NSLocalizedString("Annuler", comment: "le bouton annuler par défaut dans une popup"),
                           lightStatus: Bool = false,
                           okHandler: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alertController: UIAlertController
        if lightStatus {
            alertController = LightStatusAlertController(title: title, message: message, preferredStyle: .alert)
        } else {
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        }
        alertController.addAction(UIAlertAction(title: cancelBtn, style: .cancel))
        alertController.addAction(UIAlertAction(title: okBtn, style: .destructive, handler: okHandler))
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(alertController, animated: true)
        return alertController
    }
}

extension UIViewController {

    public var isModal: Bool {
        if self.presentingViewController != nil {
            if let navigation = self.navigationController, navigation.children.count > 1 {
                return false
            }
            return true
        } else if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController {
            return true
        } else if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
}

public extension UIViewController {
    func setBackButton(preventModal: Bool = false) {
        if isModal && !preventModal {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Fermer", comment: "Titre de la navbar pour le bouton fermer"), style: .plain, target: nil, action: #selector(self.closeModal))
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: NSLocalizedString(" ", comment: "Titre de la navbar pour le bouton retour"), style: .plain, target: nil, action: nil)
    }

    @objc func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }
}
