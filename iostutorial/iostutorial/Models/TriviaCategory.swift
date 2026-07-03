//
//  TriviaCategory.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-02.
//

import Foundation

struct TriviaCategory: Identifiable,Hashable {

    let id: Int
    let name: String

    static let all: [TriviaCategory] = [
        TriviaCategory(id: 9, name: "General Knowledge"),
        TriviaCategory(id: 17, name: "Science & Nature"),
        TriviaCategory(id: 21, name: "Sports"),
        TriviaCategory(id: 23, name: "History"),
        TriviaCategory(id: 18, name: "Computers"),
        TriviaCategory(id: 22, name: "Geography")
    ]
}
