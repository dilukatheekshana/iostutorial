import SwiftUI

struct QuizRushView: View
{

    @ObservedObject var viewModel: QuizRushViewModel
    
    @State private var showResults = false

    var body: some View
    {

        ZStack
        {
            
            if viewModel.showFlash
            {

                Color(viewModel.flashIsCorrect ? .green : .red)
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .transition(.opacity)

            }

            Color.black
                .ignoresSafeArea()

            switch viewModel.state
            {

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

                if let question = viewModel.currentQuestion
                {

                    VStack(spacing: 25) {

                        HStack
                        {

                            VStack(alignment: .leading)
                            {

                                Text("Score")
                                    .foregroundStyle(.gray)

                                Text("\(viewModel.score)")
                                    .bold()
                                    .foregroundStyle(.indigo)

                            }

                            Spacer()

                            VStack(alignment: .trailing)
                            {

                                Text("Streak")
                                    .foregroundStyle(.gray)

                                Text("\(viewModel.streak)")
                                    .bold()
                                    .foregroundStyle(.white)

                            }

                        }


                        VStack(spacing: 8)
                        {

                            Text("Question \(viewModel.currentQuestionIndex + 1) of \(viewModel.questions.count)")
                                .foregroundStyle(.gray)

                            ProgressView(
                                value: Double(viewModel.currentQuestionIndex + 1),
                                total: Double(viewModel.questions.count)
                            )
                            .tint(.indigo)

                        }
                            .foregroundStyle(.gray)


                        Text(question.question.htmlDecoded)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding()

                        Spacer()

                        ForEach(viewModel.answers, id: \.self)
                        {
                            answer in

                            Button
                            {
                                viewModel.answerQuestion(selectedAnswer: answer)

                            } label: {

                                Text(answer)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(buttonColor(answer))
                                    .cornerRadius(14)

                            }
                            .disabled(viewModel.answerSubmitted)

                        }

                        Spacer()

                    }
                    .padding()
                    

                }
                
            }
            
        }
        
        .navigationDestination(
            isPresented: $viewModel.gameFinished
        ) {

            QuizResultView(
                viewModel: viewModel
            )

        }

    }
    
    private func buttonColor(_ answer: String) -> Color
    {

        guard viewModel.answerSubmitted,
              let question = viewModel.currentQuestion
        else
        {
            return .indigo
        }

        if answer == question.correctAnswer.htmlDecoded
        {
            return .green
        }

        if answer == viewModel.selectedAnswer
        {
            return .red
        }

        return .indigo

    }

}

#Preview
{
    QuizRushView(
        viewModel: QuizRushViewModel()
    )
}
