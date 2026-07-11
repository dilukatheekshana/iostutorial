//
//  SessionDetailView.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-09.
//

import SwiftUI

struct SessionDetailView: View
{
    let session: GameSession
    var body: some View
    {
        NavigationStack
        {
            VStack(spacing: 25)
            {
                Image(systemName: session.mode.icon)
                    .font(.system(size: 70))
                    .foregroundStyle(iconColor)

                Text(session.mode.rawValue)
                    .font(.largeTitle)
                    .bold()

                VStack(spacing: 15)
                {
                    Label(
                        "Score: \(session.score)",
                        systemImage: "trophy.fill"
                    )

                    Label(
                        session.timestamp.formatted(
                            date: .complete,
                            time: .shortened
                        ),
                        systemImage: "calendar"
                    )

                    Label(
                        String(
                            format: "%.5f, %.5f",
                            session.latitude,
                            session.longitude
                        ),
                        systemImage: "location.fill"
                    )

                }
                .font(.headline)

                Spacer()

            }
            .padding()
            .navigationTitle("Game Session")
            .navigationBarTitleDisplayMode(.inline)
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
