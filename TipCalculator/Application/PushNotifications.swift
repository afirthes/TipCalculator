import UIKit
import UserNotifications

enum PushNotifications {
    static func register(
        in application: UIApplication,
        // 1
        using notificationDelegate: UNUserNotificationCenterDelegate? = nil
    ) {
        Task {
            let center = UNUserNotificationCenter.current()

            try await center.requestAuthorization(options: [.badge, .sound, .alert])

            // 2
            center.delegate = notificationDelegate

            await MainActor.run {
                application.registerForRemoteNotifications()
            }
        }
    }
}
