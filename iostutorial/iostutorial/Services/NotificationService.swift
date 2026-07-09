//
//  NotificationService.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-09.
//

import Foundation
import UserNotifications

final class NotificationService {

    static let shared = NotificationService()

    private init() {}

    func requestPermission() {

        UNUserNotificationCenter.current()
            .requestAuthorization(
                options: [.alert, .badge, .sound]
            ) { granted, error in

                if let error = error {
                    print(error.localizedDescription)
                }

            }

    }

    func scheduleDailyNotification(at date: Date) {

        let calendar = Calendar.current

        let components = calendar.dateComponents(
            [.hour, .minute],
            from: date
        )

        let content = UNMutableNotificationContent()

        content.title = "🎮 Daily Challenge"

        content.body = "Come back and beat your best score!"

        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: "dailyChallenge",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(
                withIdentifiers: ["dailyChallenge"]
            )

        UNUserNotificationCenter.current()
            .add(request)

    }

    func cancelNotifications() {

        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(
                withIdentifiers: ["dailyChallenge"]
            )

    }

}
