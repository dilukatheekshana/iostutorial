import Foundation
internal import Combine

@MainActor
class QuizRushViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var questions: [TriviaQuestion] = []

    @Published var currentQuestionIndex = 0

    @Published var score = 0

    @Published var streak = 0

    @Published var isLoading = false

    @Published var errorMessage: String?

    @Published var gameFinished = false

    // MARK: - API Service

    private let apiService = TriviaAPIService()

    // MARK: - Computed Property

    var currentQuestion: TriviaQuestion? {
        guard currentQuestionIndex < questions.count else {
            return nil
        }

        return questions[currentQuestionIndex]
    }

    // MARK: - Load Questions

    func loadQuestions(category: Int?, difficulty: String?) async {

        isLoading = true
        errorMessage = nil
        gameFinished = false

        do {

            questions = try await apiService.fetchQuestions(
                category: category,
                difficulty: difficulty
            )

            currentQuestionIndex = 0
            score = 0
            streak = 0

        } catch {

            errorMessage = "Unable to load questions.\nPlease check your internet connection."

        }

        isLoading = false
    }

    // MARK: - Answer Question

    func answerQuestion(selectedAnswer: String) {

        guard let question = currentQuestion else {
            return
        }

        if selectedAnswer == question.correctAnswer {

            score += 10
            streak += 1

            if streak >= 3 {
                score += 5
            }

        } else {

            score = max(score - 2, 0)
            streak = 0

        }

        nextQuestion()
    }

    // MARK: - Next Question

    private func nextQuestion() {

        if currentQuestionIndex < questions.count - 1 {

            currentQuestionIndex += 1

        } else {

            gameFinished = true

        }
    }

    // MARK: - Restart Game

    func resetGame() {

        questions.removeAll()
        currentQuestionIndex = 0
        score = 0
        streak = 0
        errorMessage = nil
        gameFinished = false

    }

}
