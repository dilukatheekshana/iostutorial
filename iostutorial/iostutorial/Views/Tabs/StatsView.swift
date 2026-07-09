//
//  StatsView.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import SwiftUI
import Charts

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

                        if viewModel.gameStatistics.isEmpty {
                            ContentUnavailableView(
                                "No Statistics",
                                systemImage: "chart.bar.xaxis",
                                description: Text("Play a game to begin tracking your progress.")
                            )
                        } else {
                                                                            
                            ForEach(viewModel.gameStatistics, id: \.mode) {
                                GameStatisticsCard(statistics: $0)
                            }
                        }
                    }
                    
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 18
                    ) {

                        ScoreBadge(
                            title: "Games Played",
                            value: "\(viewModel.totalGames)",
                            icon: "gamecontroller.fill",
                            color: .blue
                        )

                        ScoreBadge(
                            title: "Game Modes",
                            value: "\(GameMode.allCases.count)",
                            icon: "square.grid.2x2.fill",
                            color: .purple
                        )

                    }
                    
                    Divider()
                        .background(.gray)

                    VStack(alignment: .leading, spacing: 18) {

                        Text("Score Progress")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)

                        Chart {


                            ForEach(Array(viewModel.sessions(for: .tapFrenzy).enumerated()), id: \.element.id) { index, session in

                                LineMark(
                                    x: .value("Game Count", index + 1),
                                    y: .value("Score", session.score),
                                    series: .value("Game Mode", "Tap Frenzy")
                                )
                                .foregroundStyle(.red)
                                .lineStyle(StrokeStyle(lineWidth: 3))
                                .interpolationMethod(.catmullRom)

                                PointMark(
                                    x: .value("Game Count", index + 1),
                                    y: .value("Score", session.score)
                                )
                                .foregroundStyle(.red)
                            }

 
                            ForEach(Array(viewModel.sessions(for: .lightItUp).enumerated()), id: \.element.id) { index, session in

                                LineMark(
                                    x: .value("Game Count", index + 1),
                                    y: .value("Score", session.score),
                                    series: .value("Game Mode", "Light It Up")
                                )
                                .foregroundStyle(.yellow)
                                .lineStyle(StrokeStyle(lineWidth: 3))
                                .interpolationMethod(.catmullRom)

                                PointMark(
                                    x: .value("Game Count", index + 1),
                                    y: .value("Score", session.score)
                                )
                                .foregroundStyle(.yellow)
                            }


                            ForEach(Array(viewModel.sessions(for: .quizRush).enumerated()), id: \.element.id) { index, session in

                                LineMark(
                                    x: .value("Game Count", index + 1),
                                    y: .value("Score", session.score),
                                    series: .value("Game Mode", "Quiz Rush")
                                )
                                .foregroundStyle(.blue)
                                .lineStyle(StrokeStyle(lineWidth: 3))
                                .interpolationMethod(.catmullRom)

                                PointMark(
                                    x: .value("Game Count", index + 1),
                                    y: .value("Score", session.score)
                                )
                                .foregroundStyle(.blue)
                            }

                        }
                        .frame(height: 300)
                        .chartXScale(range: .plotDimension(padding: 20))
                        .chartXAxis {
                            AxisMarks(values: .automatic) { _ in
                                AxisGridLine()
                                AxisValueLabel()
                                    .foregroundStyle(.white)
                            }
                        }
                        .chartYAxis {
                            AxisMarks(position: .leading) { _ in
                                AxisGridLine()
                                AxisValueLabel()
                                    .foregroundStyle(.white)
                            }
                        }
                        .chartXAxisLabel {
                            Text("Game Count")
                                .foregroundStyle(.white)
                        }
                        .chartYAxisLabel {
                            Text("Score")
                                .foregroundStyle(.white)
                        }
                        .chartLegend(position: .top) {
                            HStack(spacing: 20) {
                                Label("Tap Frenzy", systemImage: "line.diagonal")
                                    .foregroundStyle(.red)
                                Label("Light It Up", systemImage: "line.diagonal")
                                    .foregroundStyle(.yellow)
                                Label("Quiz Rush", systemImage: "line.diagonal")
                                    .foregroundStyle(.blue)
                            }
                        }
                        .chartPlotStyle { plotArea in
                            plotArea
                                .background(Color.white.opacity(0.05))
                                .cornerRadius(12)
                        }

                    }
                    
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

private func chartColor(for mode: GameMode) -> Color {
    switch mode {
    case .tapFrenzy:
        return .red
    case .lightItUp:
        return .yellow
    case .quizRush:
        return .blue
    }
}
