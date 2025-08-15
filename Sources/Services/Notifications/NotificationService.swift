import UserNotifications

enum NotificationService {
    static func request() async {
        _ = try? await UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert,.sound,.badge])
    }

    static func schedule(title: String, after seconds: TimeInterval) async {
        let content = UNMutableNotificationContent()
        content.title = title
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(1, seconds), repeats: false)
        let req = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        try? await UNUserNotificationCenter.current().add(req)
    }
}