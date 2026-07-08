//
//  GameSessionService.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import Foundation
internal import _LocationEssentials

final class GameSessionService {

    static let shared = GameSessionService()

    private let storageKey = "game_sessions"

    private init() {}

    func loadSessions() -> [GameSession] {
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let sessions = try? JSONDecoder().decode([GameSession].self, from: data)
        else {
            return []
        }

        return sessions.sorted { $0.timestamp > $1.timestamp }
    }

    func addSession(_ session: GameSession) {

        let location = LocationService.shared.currentLocation

        let updatedSession = GameSession(
            id: session.id,
            mode: session.mode,
            score: session.score,
            timestamp: session.timestamp,
            latitude: location?.coordinate.latitude ?? 0,
            longitude: location?.coordinate.longitude ?? 0
        )

        var sessions = loadSessions()

        sessions.append(updatedSession)

        saveSessions(sessions)

        NotificationCenter.default.post(
            name: .gameSessionsUpdated,
            object: nil
        )
    }

    func saveSessions(_ sessions: [GameSession]) {
        guard let data = try? JSONEncoder().encode(sessions) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    func deleteAllSessions() {
        UserDefaults.standard.removeObject(forKey: storageKey)
    }

    // MARK: - Statistics

    var totalGames: Int {
        loadSessions().count
    }

    var highestScore: Int {
        loadSessions().map(\.score).max() ?? 0
    }

    var averageScore: Double {
        let sessions = loadSessions()

        guard !sessions.isEmpty else { return 0 }

        let total = sessions.reduce(0) { $0 + $1.score }

        return Double(total) / Double(sessions.count)
    }
    
}

extension Notification.Name {
    static let gameSessionsUpdated = Notification.Name("gameSessionsUpdated")
}
