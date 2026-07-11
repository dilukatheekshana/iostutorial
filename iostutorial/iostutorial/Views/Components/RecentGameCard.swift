//
//  RecentGameCard.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import SwiftUI

struct RecentGameCard: View
{

    let session: GameSession

    var body: some View
    {
        HStack(spacing: 16)
        {
            
            Image(systemName: session.mode.icon)
                .font(.system(size: 24))
                .foregroundStyle(iconColor)

                .frame(width: 40)

            VStack(alignment: .leading, spacing: 6)
            {

                Text(session.mode.rawValue)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text("Score: \(session.score)")
                    .foregroundStyle(.gray)

                Text(session.timestamp.formatted(
                    date: .abbreviated,
                    time: .shortened
                ))
                .font(.caption)
                .foregroundStyle(.secondary)

            }

            Spacer()

        }
        .padding()
        .background(Color.white.opacity(0.08))
        .cornerRadius(16)
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

#Preview
{
    ZStack
    {
        Color.black.ignoresSafeArea()
        RecentGameCard(
            session: GameSession(
                mode: .quizRush,
                score: 40
            )
        )
        .padding()
    }
}
