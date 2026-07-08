//
//  GameStatisticsCard.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import SwiftUI

struct GameStatisticsCard: View {

    let statistics: StatsViewModel.GameStatistics

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            HStack {

                Image(systemName: statistics.mode.icon)
                    .foregroundStyle(iconColor)

                Text(statistics.mode.rawValue)
                    .font(.headline)
                    .foregroundStyle(.white)

            }

            Divider()

            statisticRow(
                title: "Games Played",
                value: "\(statistics.gamesPlayed)"
            )

            statisticRow(
                title: "Highest Score",
                value: "\(statistics.highestScore)"
            )

            statisticRow(
                title: "Average",
                value: String(format: "%.1f", statistics.averageScore)
            )

        }
        .padding()
        .background(Color.white.opacity(0.08))
        .cornerRadius(18)

    }

    @ViewBuilder
    private func statisticRow(title: String, value: String) -> some View {

        HStack {

            Text(title)
                .foregroundStyle(.gray)

            Spacer()

            Text(value)
                .foregroundStyle(.white)
                .fontWeight(.bold)

        }

    }

    private var iconColor: Color {

        switch statistics.mode {

        case .tapFrenzy:
            return .red

        case .lightItUp:
            return .yellow

        case .quizRush:
            return .blue

        }

    }

}
