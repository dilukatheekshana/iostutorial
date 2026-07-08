//
//  StatsView.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import SwiftUI

struct StatsView: View {

    @StateObject private var viewModel = StatsViewModel()

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 25) {

                    Text("Statistics")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Divider()
                        .background(Color.gray)

                    VStack(alignment: .leading, spacing: 18) {

                        Text("Performance by Game")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)

                        ForEach(viewModel.gameStatistics, id: \.mode) {

                            GameStatisticsCard(statistics: $0)

                        }

                    }
                    
//                    LazyVGrid(
//                        columns: [
//                            GridItem(.flexible()),
//                            GridItem(.flexible())
//                        ],
//                        spacing: 18
//                    ) {
//
//                        ScoreBadge(
//                            title: "Games Played",
//                            value: "\(viewModel.totalGames)",
//                            icon: "gamecontroller.fill",
//                            color: .blue
//                        )
//
//                        ScoreBadge(
//                            title: "Highest Score",
//                            value: "\(viewModel.highestScore)",
//                            icon: "trophy.fill",
//                            color: .yellow
//                        )
//
//                        ScoreBadge(
//                            title: "Average Score",
//                            value: String(format: "%.1f", viewModel.averageScore),
//                            icon: "chart.bar.fill",
//                            color: .green
//                        )
//
//                        ScoreBadge(
//                            title: "Game Modes",
//                            value: "\(GameMode.allCases.count)",
//                            icon: "square.grid.2x2.fill",
//                            color: .purple
//                        )
//
//                    }
                    
                    Divider()
                        .background(Color.gray)

                    VStack(alignment: .leading, spacing: 16) {

                        Text("Recent Games")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)

                        if viewModel.recentSessions.isEmpty {

                            ContentUnavailableView(
                                "No Games Played",
                                systemImage: "gamecontroller",
                                description: Text("Play one of the games to start tracking your progress.")
                            )

                        } else {

                            ForEach(viewModel.recentSessions) { session in

                                RecentGameCard(session: session)

                            }

                        }

                    }
                    
                    

                    Spacer(minLength: 30)

                }
                .padding()

            }
            .background(Color.black)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.loadSessions()
            }
            .onReceive(
                NotificationCenter.default.publisher(
                    for: .gameSessionsUpdated
                )
            ) { _ in
                viewModel.loadSessions()
            }

        }

    }

}

#Preview {

    StatsView()

}
