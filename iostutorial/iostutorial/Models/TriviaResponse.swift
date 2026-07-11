//
//  TriviaResponse.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-02.
//

import Foundation

struct TriviaResponse: Codable
{
    let responseCode: Int
    let results: [TriviaQuestion]

    enum CodingKeys: String, CodingKey
    {
        case responseCode = "response_code"
        case results
    }
}
