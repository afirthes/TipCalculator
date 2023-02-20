import UserNotifications

final class NotificationCenter: NSObject {
    @Published var isBeachViewActive = false
}

extension NotificationCenter: ObservableObject {}

extension NotificationCenter: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _: UNUserNotificationCenter,
        willPresent _: UNNotification
    ) async -> UNNotificationPresentationOptions {
        [.banner, .sound, .badge]
    }

    func userNotificationCenter(
        _: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {
        if response.notification.request.content.userInfo["beach"] != nil {
            // In a real app you'd likely pull a URL from the beach data
            // and use that image.
            await MainActor.run {
                isBeachViewActive = true
            }
        }
    }
}
