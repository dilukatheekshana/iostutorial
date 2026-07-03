import SwiftUI

struct QuizRushView: View {

    @ObservedObject var viewModel: QuizRushViewModel
    @State private var showResults = false

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            switch viewModel.state {

            case .idle:

                ProgressView()

            case .loading:

                VStack(spacing: 20) {

                    ProgressView()

                    Text("Loading Questions...")
                        .foregroundStyle(.white)

                }

            case .failed(let message):

                VStack(spacing: 20) {

                    Image(systemName: "wifi.slash")
                        .font(.system(size: 50))
                        .foregroundStyle(.red)

                    Text(message)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)

                }

            case .loaded:

                if let question = viewModel.currentQuestion {

                    VStack(spacing: 25) {

                        // Score Row

                        HStack {

                            Label("Score: \(viewModel.score)", systemImage: "star.fill")
                                .foregroundStyle(.yellow)

                            Spacer()

                            Label("Streak: \(viewModel.streak)", systemImage: "flame.fill")
                                .foregroundStyle(.orange)

                        }

                        // Progress

                        Text("Question \(viewModel.currentQuestionIndex + 1) of \(viewModel.questions.count)")
                            .foregroundStyle(.gray)

                        // Question

                        Text(question.question)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding()

                        Spacer()

                        // Answers

                        ForEach(question.allAnswers, id: \.self) { answer in

                            PrimaryButton(title: answer) {

                                viewModel.answerQuestion(selectedAnswer: answer)

                            }

                        }

                        Spacer()

                    }
                    .padding()

                }

            }

        }

    }

}

#Preview {
    QuizRushView(
        viewModel: QuizRushViewModel()
    )
}
