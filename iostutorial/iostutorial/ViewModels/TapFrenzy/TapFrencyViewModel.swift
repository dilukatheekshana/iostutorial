//
//  TapFrencyViewModel.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-09.
//

import SwiftUI
internal import Combine

class TapFrenzyViewModel: ObservableObject {
    
    // MARK: - Game State
    
    @Published var score = 0
    @Published var highScore = 0
    @Published var timeRemaining = 10
    @Published var gameOver = false
    
    // Moving Target Position
    @Published var buttonX: CGFloat = 200
    @Published var buttonY: CGFloat = 500
    
    // MARK: - Shrinking Button Challenge
    
    var buttonSize: CGFloat {
        switch timeRemaining {
        case 8...10:
            return 150
        case 5...7:
            return 120
        case 2...4:
            return 90
        default:
            return 60
        }
    }
    
    // MARK: - Game Logic
    
    func tapButton() {
        score += 1
    }
    
    func setInitialPosition(geometry: GeometryProxy) {
        buttonX = geometry.size.width / 2
        buttonY = geometry.size.height * 0.70
    }
    
    func moveTarget(geometry: GeometryProxy) {
        if !gameOver {
            withAnimation(.easeInOut(duration: 0.5)) {
                buttonX = CGFloat.random(
                    in: 80...(geometry.size.width - 80)
                )
                buttonY = CGFloat.random(
                    in: 250...(geometry.size.height - 120)
                )
            }
        }
    }
    
    func processTimerTick() {
        if !gameOver {
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                gameOver = true
                
                //implement game session service
                GameSessionService.shared.addSession(
                    GameSession(
                        mode: .tapFrenzy,
                        score: score
                    )
                )
                
                print(GameSessionService.shared.loadSessions())
                
                if score > highScore {
                    highScore = score
                }
            }
        }
    }
    
    // MARK: - Restart Game
    
    func restartGame(geometry: GeometryProxy) {
        score = 0
        timeRemaining = 10
        gameOver = false
        
        buttonX = geometry.size.width / 2
        buttonY = geometry.size.height * 0.70
    }
}
