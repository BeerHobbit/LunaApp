import UserNotifications

final class NotificationManager {
    
    private let center: UNUserNotificationCenter
    private static let dailyNotificationID: String = "dailyNotification."
    
    init(center: UNUserNotificationCenter = .current()) {
        self.center = center
        setupNotifications()
    }
    
    private func setupNotifications() {
        Task {
            try? await requestPermission()
            scheduleDailyNotification(hour: 12, minute: 00)
            scheduleDailyNotification(hour: 21, minute: 00)
        }
    }
    
    private func requestPermission() async throws {
        try await center.requestAuthorization(options: [.alert, .badge, .sound])
    }
    
    private func scheduleDailyNotification(hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = String(localized: .notificationTitle)
        content.body = String(localized: .notificationBody)
        content.sound = .default
        
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: "\(Self.dailyNotificationID)\(hour):\(minute)",
            content: content,
            trigger: trigger
        )
        
        center.add(request)
    }

}
