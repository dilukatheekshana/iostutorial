//
//  GameMapAnnotation.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-09.
//

import SwiftUI

struct GameMapAnnotation: View
{

    let session: GameSession

    var body: some View
    {
        VStack(spacing: 4)
        {
            Image(systemName: session.mode.icon)
                .font(.title2)
                .foregroundStyle(iconColor)

            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundStyle(iconColor)
        }
    }

    private var iconColor: Color
    {
        switch session.mode
        {
        case .tapFrenzy:
            return .blue

        case .lightItUp:
            return .green

        case .quizRush:
            return .indigo
        }
    }

}
