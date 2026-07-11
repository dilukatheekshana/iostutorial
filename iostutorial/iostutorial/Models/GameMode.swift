//
//  GameMode.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import Foundation

enum GameMode: String, Codable, CaseIterable
{
    case tapFrenzy = "Tap Frenzy"
    case lightItUp = "Light It Up"
    case quizRush = "Quiz Rush"

    var icon: String
    {
        switch self
        {
        case .tapFrenzy:
            return "hand.tap.fill"

        case .lightItUp:
            return "lightbulb.fill"

        case .quizRush:
            return "brain.head.profile"
        }
    }

    var colorName: String
    {
        switch self
        {
        case .tapFrenzy:
            return "blue"

        case .lightItUp:
            return "green"

        case .quizRush:
            return "indigo"
        }
    }
}
