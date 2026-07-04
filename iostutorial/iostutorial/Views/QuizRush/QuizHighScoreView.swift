import SwiftUI

struct QuizHighScoreView: View {

    @ObservedObject var viewModel: QuizRushViewModel

    @Environment(\.dismiss) private var dismiss

    var body: some View {

        ZStack {

            Color.black.ignoresSafeArea()

            VStack(spacing: 30) {

                Spacer()

                Text("🏆 High Scores")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)

                VStack(spacing: 20) {

                    VStack {

                        Text("Best Score")
                            .foregroundStyle(.gray)

                        Text("\(viewModel.highScore)")
                            .font(.system(size: 50))
                            .bold()
                            .foregroundStyle(.yellow)

                    }

                    Divider().background(.white.opacity(0.3))

                    VStack {

                        Text("Last Score")
                            .foregroundStyle(.gray)

                        Text("\(viewModel.score)")
                            .font(.system(size: 40))
                            .bold()
                            .foregroundStyle(.white)

                    }

                }

                Spacer()

                PrimaryButton(title: "Back") {
                    dismiss()
                }

            }
            .padding()

        }

    }
}
