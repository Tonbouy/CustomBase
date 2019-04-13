//
//  UNUserNotificationCenterExtensions.swift
//  UNUserNotificationCenterExtensions
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import UserNotifications
import UIKit

public extension UNUserNotificationCenter {

    func requestAuthorization(openSettings: Bool,
                                     completion: ((_ granted: Bool, _ error: Swift.Error?) -> Void)? = nil) {
        let start = ProcessInfo.processInfo.systemUptime
        
        requestAuthorization(options: [.alert, .sound, .badge]) { [unowned self] granted, error in
            completion?(granted, error)
            if granted {
                self.register()
            } else if openSettings && (ProcessInfo.processInfo.systemUptime - start < 0.1) {
                UIApplication.openAppSettings()
            }
        }
    }
    
    func register() {
        checkAuthorization { granted in
            if granted {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func checkAuthorization(_ completion: @escaping (_ granted: Bool) -> Void) {
        getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus == .authorized)
            }
        }
    }
}
