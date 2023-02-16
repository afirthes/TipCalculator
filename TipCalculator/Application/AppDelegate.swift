//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Afir Thes on 12.02.2023.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 10.0, *) {
                    // For iOS 10 display notification (sent via APNS)
                    UNUserNotificationCenter.current().delegate = self

                    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                    UNUserNotificationCenter.current().requestAuthorization(
                        options: authOptions) { rez, error in
                            
                            print(rez)
                            print(error)
                            
                        }
                } else {
                    let settings: UIUserNotificationSettings =
                        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                    application.registerUserNotificationSettings(settings)
                }

                application.registerForRemoteNotifications()
        
        return true
    }

    
    // [START receive_message] remote notification
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {

//            // Print message ID.
//            if let messageID = userInfo[gcmMessageIDKey] {
//                print("Message ID: \(messageID)")
//            }

            // Print full message.

            print(userInfo)

        }

    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                         fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            // Print message ID.
//            if let messageID = userInfo[gcmMessageIDKey] {
//                print("Message ID: \(messageID)")
//            }

            // Print full message.
            print(userInfo)
            completionHandler(UIBackgroundFetchResult.newData)

        }

        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            print("Unable to register for remote notifications: \(error.localizedDescription)")
        }

        // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
        // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
        // the FCM registration token.
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            var token = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
            //
                        print("Device Token = \(token)")

            // With swizzling disabled you must set the APNs token here.
            // Messaging.messaging().apnsToken = deviceToken
        }
    
    
   
//    private func registerForPushNotifications() {
//        UNUserNotificationCenter.current().delegate = self
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
//            (granted, error) in
//            // 1. Check to see if permission is granted
//            guard granted else { return }
//            // 2. Attempt registration for remote notifications on the main thread
//            DispatchQueue.main.async {
//                UIApplication.shared.registerForRemoteNotifications()
//                print("regitered for notifications")
//            }
//        }
//    }
    
    
    
    
}


//extension AppDelegate: UNUserNotificationCenterDelegate {
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        var token = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
//
//            print("Device Token = \(token)")
//
//
//        print("Device uuid = \(UIDevice.current.identifierForVendor?.uuidString)")
//    }
//
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print(error)
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//
//        print("Did receive")
//
//    }
//
//
//    func application(application: UIApplication,  didReceiveRemoteNotification userInfo: [NSObject : AnyObject],  fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
//
//        print("Recived: \(userInfo)")
//
//        completionHandler(.newData)
//
//    }
//}
