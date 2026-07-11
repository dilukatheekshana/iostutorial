//
//  StatsViewModel.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class StatsViewModel: ObservableObject
{

    @Published var sessions: [GameSession] = []

    private let sessionService = GameSessionService.shared

    init()
    {
        loadSessions()
    }

    func loadSessions()
    {
        sessions = sessionService.loadSessions()
    }

    var totalGames: Int
    {
        sessions.count
    }

    var highestScore: Int
    {
        sessions.map(\.score).max() ?? 0
    }

    var averageScore: Double
    {
        guard !sessions.isEmpty
        else
        {
            return 0
        }

        let total = sessions.reduce(0)
        {
            $0 + $1.score
        }

        return Double(total) / Double(sessions.count)
    }

    var recentSessions: [GameSession]
    {
        sessions
    }

    func sessions(for mode: GameMode) -> [GameSession]
    {
        sessions.filter
        {
            $0.mode == mode
        }
    }

    func totalGames(for mode: GameMode) -> Int
    {
        sessions(for: mode).count
    }

    func highestScore(for mode: GameMode) -> Int
    {
        sessions(for: mode)
            .map(\.score)
            .max() ?? 0
    }

    func averageScore(for mode: GameMode) -> Double
    {
        let gameSessions = sessions(for: mode)

        guard !gameSessions.isEmpty
        else
        {
            return 0
        }

        let total = gameSessions.reduce(0)
        {
            $0 + $1.score
        }

        return Double(total) / Double(gameSessions.count)
    }

    func resetAllSessions()
    {
        sessionService.deleteAllSessions()
        loadSessions()
    }

    struct GameStatistics
    {
        let mode: GameMode
        let gamesPlayed: Int
        let highestScore: Int
        let averageScore: Double
    }

    var gameStatistics: [GameStatistics]
    {
        GameMode.allCases.map
        {
            mode in
            
            let gameSessions = sessions.filter
            {
                $0.mode == mode
            }
            
            let highest = gameSessions.map(\.score).max() ?? 0
            
            let average: Double

            if gameSessions.isEmpty
            {
                average = 0

            }
            else
            {
                let total = gameSessions.reduce(0)
                {
                    $0 + $1.score
                }
                average = Double(total) / Double(gameSessions.count)
            }

            return GameStatistics(
                mode: mode,
                gamesPlayed: gameSessions.count,
                highestScore: highest,
                averageScore: average
            )

        }
    }
}
