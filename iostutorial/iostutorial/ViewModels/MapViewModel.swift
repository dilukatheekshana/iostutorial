//
//  MapViewModel.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-09.
//

import Foundation
import MapKit
internal import Combine

@MainActor
final class MapViewModel: ObservableObject {

    @Published var sessions: [GameSession] = []
    @Published var selectedSession: GameSession?

    init() {
        loadSessions()
    }

    func loadSessions() {
        sessions = GameSessionService.shared.loadSessions()
    }

}
