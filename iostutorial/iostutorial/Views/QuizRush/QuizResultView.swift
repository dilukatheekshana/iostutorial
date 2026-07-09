import SwiftUI

struct QuizResultView: View {

    @ObservedObject var viewModel: QuizRushViewModel

    @Environment(\.dismiss) private var dismiss

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            VStack(spacing: 25) {

                Spacer()

                Image(systemName: "trophy.fill")
                    .font(.system(size: 70))
                    .foregroundColor(.yellow)

                Text("Quiz Complete!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)

                VStack(spacing: 12) {

                    Text("Final Score")

                    Text("\(viewModel.score)")
                        .font(.system(size: 55))
                        .bold()

                }
                .foregroundStyle(.white)

                VStack(spacing: 10) {

                    Label(
                        "Correct Answers: \(viewModel.correctAnswers)/10",
                        systemImage: "checkmark.circle.fill"
                    )

                    Label(
                        "Accuracy: \(viewModel.accuracy)%",
                        systemImage: "chart.bar.fill"
                    )

                    Label(
                        "Best Streak: \(viewModel.streak)",
                        systemImage: "flame.fill"
                    )

                }
                .foregroundStyle(.white)

                Spacer()

                PrimaryButton(title: "Play Again") {

                    viewModel.resetGame()

                    dismiss()

                }

//                Button("Back to Home") {
//
//                    MainTabView()
//
//                }
//                .foregroundStyle(.gray)
                ShareLink(
                    item: "🧠 I scored \(viewModel.score) points in Quiz Rush on PlayHub!"
                ) {

                    Label("Share Score", systemImage: "square.and.arrow.up")
                        .frame(width: 220)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(14)

                }

            }
            .padding()

        }

        .navigationBarBackButtonHidden()

    }

}

#Preview {

    QuizResultView(
        viewModel: QuizRushViewModel()
    )

}
