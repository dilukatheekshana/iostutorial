//
//  SettingsViewModel.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-09.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class SettingsViewModel: ObservableObject {

    @AppStorage("notificationsEnabled")
    var notificationsEnabled = false

    @AppStorage("dailyChallengeTime")
    private var storedTime = Date().timeIntervalSince1970

    var challengeTime: Date {
        get {
            Date(timeIntervalSince1970: storedTime)
        }
        set {
            storedTime = newValue.timeIntervalSince1970

            if notificationsEnabled {
                NotificationService.shared.scheduleDailyNotification(at: newValue)
            }
        }
    }

    func toggleNotifications() {

        notificationsEnabled.toggle()

        if notificationsEnabled {

            NotificationService.shared.requestPermission()

            NotificationService.shared.scheduleDailyNotification(
                at: challengeTime
            )

        } else {

            NotificationService.shared.cancelNotifications()

        }

    }

    func resetStatistics() {

        GameSessionService.shared.deleteAllSessions()

    }

}
