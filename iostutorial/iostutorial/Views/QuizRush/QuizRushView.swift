import SwiftUI

struct QuizRushView: View {

    @ObservedObject var viewModel: QuizRushViewModel

    var body: some View {

        ZStack {

            Color.black.ignoresSafeArea()

            switch viewModel.state {

            case .loading:

                VStack(spacing: 12) {
                    ProgressView()
                    Text("Loading Questions...")
                        .foregroundStyle(.white)
                }

            case .failed(let message):

                VStack(spacing: 12) {
                    Image(systemName: "wifi.slash")
                        .font(.largeTitle)
                        .foregroundStyle(.red)

                    Text(message)
                        .foregroundStyle(.white)

                    PrimaryButton(title: "Retry") {
                        Task {
                            await viewModel.loadQuestions(category: nil, difficulty: nil)
                        }
                    }
                }

            case .loaded:

                if viewModel.showResult {

                    EmptyView()

                } else {

                    VStack(spacing: 20) {

                        // SCORE
                        HStack {
                            Text("Score: \(viewModel.score)")
                                .foregroundStyle(.yellow)

                            Spacer()

                            Text("🔥 \(viewModel.streak)")
                                .foregroundStyle(.orange)
                        }

                        // QUESTION
                        if let question = viewModel.currentQuestion {

                            Text(question.question.htmlDecoded)
                                .font(.title2)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                        }

                        // ANSWERS
                        ForEach(viewModel.currentAnswers, id: \.self) { answer in

                            PrimaryButton(title: answer) {

                                viewModel.answerQuestion(selectedAnswer: answer)
                            }
                            .opacity(viewModel.isProcessing ? 0.6 : 1)
                        }

                        Spacer()

                        Text("Question \(viewModel.currentQuestionIndex + 1) / \(viewModel.questions.count)")
                            .foregroundStyle(.gray)
                    }
                    .padding()
                }

            case .idle:
                ProgressView()
            }
        }
        .navigationDestination(isPresented: $viewModel.showResult) {

            QuizResultView(
                score: viewModel.score,
                totalQuestions: viewModel.questions.count
            )
        }
    }
}
