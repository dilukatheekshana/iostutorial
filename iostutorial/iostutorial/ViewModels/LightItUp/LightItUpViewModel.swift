//
//  LightItUpViewModel.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-09.
//

import SwiftUI
internal import Combine

struct GameCard: Identifiable
{
    let id = UUID()
    var isLit = false
}

class LightItUpViewModel: ObservableObject
{
    
    @Published var cards: [GameCard] = []
    @Published var score = 0
    @Published var timeRemaining = 60
    @Published var gameOver = false
    @Published var currentLevel = 1
    
    @Published var highScore: Int
    {
        didSet
        {
            UserDefaults.standard.set(highScore, forKey: "LightItUpHighScore")
        }
    }
    
    init()
    {
        self.highScore = UserDefaults.standard.integer(forKey: "LightItUpHighScore")
    }
    
    var gridColumns: Int
    {
        switch currentLevel
        {
        case 1:
            return 3
        case 2:
            return 4
        case 3:
            return 3
        default:
            return 3
        }
    }

    var levelColor: Color
    {
        switch currentLevel
        {
        case 1:
            return .yellow
        case 2:
            return .green
        case 3:
            return .orange
        default:
            return .red
        }
    }
    
    func cardTapped(at index: Int)
    {
        if cards[index].isLit
        {
            score += 1
            cards[index].isLit = false
        }
        else
        {
            score = max(0, score - 1)
        }
    }
    
    func processGameTimer()
    {
        if !gameOver
        {
            timeRemaining -= 1
            updateLevel()

            if timeRemaining <= 0
            {
                gameOver = true
                
                GameSessionService.shared.addSession(
                    GameSession(
                        mode: .lightItUp,
                        score: score
                    )
                )
                
                print(GameSessionService.shared.loadSessions())

                if score > highScore
                {
                    highScore = score
                }
            }
        }
    }
    
    func processLightTimer()
    {
        if !gameOver
        {
            lightRandomCards()
        }
    }
    
    func updateLevel()
    {
        let elapsed = 60 - timeRemaining
        let newLevel: Int

        if elapsed < 15
        {
            newLevel = 1
        } else if elapsed < 30
        {
            newLevel = 2
        } else if elapsed < 45
        {
            newLevel = 3
        } else
        {
            newLevel = 4
        }

        if newLevel != currentLevel
        {
            currentLevel = newLevel
            setupCards()
        }
    }

    func setupCards()
    {
        switch currentLevel
        {
        case 1:
            cards = Array(repeating: GameCard(), count: 3)
        case 2:
            cards = Array(repeating: GameCard(), count: 4)
        case 3:
            cards = Array(repeating: GameCard(), count: 6)
        default:
            cards = Array(repeating: GameCard(), count: 9)
        }
    }

    func lightRandomCards()
    {
        for index in cards.indices
        {
            cards[index].isLit = false
        }

        if cards.isEmpty
        {
            return
        }

        if currentLevel == 4
        {
            let first = Int.random(in: 0..<cards.count)
            var second = Int.random(in: 0..<cards.count)

            while second == first
            {
                second = Int.random(in: 0..<cards.count)
            }

            cards[first].isLit = true
            cards[second].isLit = true
        }
        else
        {
            let random = Int.random(in: 0..<cards.count)
            cards[random].isLit = true
        }
    }

    func restartGame()
    {
        score = 0
        timeRemaining = 60
        gameOver = false
        currentLevel = 1
        setupCards()
        lightRandomCards()
    }
}
