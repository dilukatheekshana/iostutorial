import SwiftUI

struct QuizSetupView: View {

    @StateObject private var viewModel = QuizRushViewModel()

    @State private var selectedCategory: TriviaCategory? = TriviaCategory.all.first

    @State private var selectedDifficulty = "easy"

    @State private var startQuiz = false

    private let difficulties = [
        "easy",
        "medium",
        "hard"
    ]
    
    // MARK: - Custom Initialization for Picker Colors
        init() {
            // 1. Set the unselected text color to white
            UISegmentedControl.appearance().setTitleTextAttributes(
                [.foregroundColor: UIColor.white], for: .normal
            )
            
            // 2. Set the selected text color to black
            UISegmentedControl.appearance().setTitleTextAttributes(
                [.foregroundColor: UIColor.black], for: .selected
            )
        }

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            VStack(spacing: 25) {

                Spacer()

                VStack(spacing: 8) {

                    Text("📚")
                        .font(.system(size: 60))

                    Text("Quiz Rush")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)

                    Text("Test Your Knowledge")
                        .foregroundStyle(.gray)

                }

                SectionCard(title: "Category") {

                    Picker("Category", selection: $selectedCategory) {

                        ForEach(TriviaCategory.all) { category in

                            Text(category.name)
                                .tag(category as TriviaCategory?)

                        }

                    }
                    .pickerStyle(.menu)
                    .tint(Color.purple)

                }

                SectionCard(title: "Difficulty") {

                    Picker("Difficulty", selection: $selectedDifficulty) {

                        ForEach(difficulties, id: \.self) { difficulty in

                            Text(difficulty.capitalized)
                                .tag(difficulty)  

                        }

                    }
                    .pickerStyle(.segmented)

                }

                PrimaryButton(title: "Start Quiz") {

                    Task {

                        await viewModel.loadQuestions(
                            category: selectedCategory?.id,
                            difficulty: selectedDifficulty
                        )

                        startQuiz = true

                    }

                }
                NavigationLink {
                    QuizHighScoreView(viewModel: viewModel)
                } label: {
                    Text("View High Scores")
                        .foregroundStyle(.white)
                }

                Spacer()

                    .navigationDestination(isPresented: $startQuiz) {
                        QuizRushView(viewModel: viewModel)
                    }

            }
            .padding()

        }
//        .navigationBarHidden(true)

    }

}

#Preview {
    QuizSetupView()
}
