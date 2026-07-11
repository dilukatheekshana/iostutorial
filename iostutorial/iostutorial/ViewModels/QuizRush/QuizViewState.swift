//
//  QuizViewState.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-02.
//

import Foundation

enum QuizViewState
{
    case idle
    case loading
    case loaded
    case failed(String)
}
