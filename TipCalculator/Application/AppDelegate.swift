//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Afir Thes on 12.02.2023.
//

import CoreData
import UIKit
import UserNotifications

@main
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    let notificationCenter = NotificationCenter()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions _:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        PushNotifications.register(in: application, using: notificationCenter)
        return true
    }

    func application(
        _: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let token = deviceToken.reduce("") { $0 + String(format: "%02x", $1) }
        print(token)
    }

    func application(_: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async -> UIBackgroundFetchResult {
        guard
            let text = userInfo["text"] as? String,
            let image = userInfo["image"] as? String,
            let url = URL(string: image)
        else {
            return .noData
        }


        print(text)
        print(image)

        return .newData

    }
    
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//
//        guard
//            let text = userInfo["text"] as? String,
//            let image = userInfo["image"] as? String,
//            let url = URL(string: image)
//          else {
//            completionHandler(.noData)
//        return
//        }
//
//    }
}
