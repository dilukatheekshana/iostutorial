//
//  TriviaQuestion.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-02.
//

import Foundation

struct TriviaQuestion: Codable, Identifiable {

    let id = UUID()

    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case category
        case type
        case difficulty
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
