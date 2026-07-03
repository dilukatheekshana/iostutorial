import Foundation
import SwiftUI
internal import Combine

@MainActor
class QuizRushViewModel: ObservableObject {

    // MARK: - Data
    @Published var questions: [TriviaQuestion] = []
    @Published var currentQuestionIndex = 0
    @Published var currentAnswers: [String] = []

    // MARK: - Score
    @Published var score = 0
    @Published var streak = 0

    // MARK: - State
    @Published var state: QuizViewState = .idle
    @Published var showResult = false

    // MARK: - UI Feedback
    @Published var selectedAnswer: String? = nil
    @Published var isAnswerCorrect: Bool? = nil
    @Published var isProcessing = false

    private let apiService = TriviaAPIService()

    // MARK: - Current Question
    var currentQuestion: TriviaQuestion? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }

    // MARK: - Load Questions
    func loadQuestions(category: Int?, difficulty: String?) async {

        state = .loading
        showResult = false

        do {
            questions = try await apiService.fetchQuestions(
                category: category,
                difficulty: difficulty
            )

            currentQuestionIndex = 0
            score = 0
            streak = 0

            prepareAnswers()
            state = .loaded

        } catch {
            state = .failed("Failed to load questions. Check internet.")
        }
    }

    // MARK: - Prepare Answers
    private func prepareAnswers() {

        guard let question = currentQuestion else { return }

        currentAnswers = ([question.correctAnswer] + question.incorrectAnswers)
            .map { $0.htmlDecoded }
            .shuffled()
    }

    // MARK: - Answer Logic (WITH ANIMATION SUPPORT)
    func answerQuestion(selectedAnswer: String) {

        guard !isProcessing else { return }
        guard let question = currentQuestion else { return }

        isProcessing = true
        self.selectedAnswer = selectedAnswer

        let correct = selectedAnswer == question.correctAnswer.htmlDecoded
        isAnswerCorrect = correct

        if correct {
            score += 10
            streak += 1

            if streak >= 3 {
                score += 5
            }

        } else {
            score = max(score - 2, 0)
            streak = 0
        }

        // Delay before next question (UX polish)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

            self.nextQuestion()

            self.selectedAnswer = nil
            self.isAnswerCorrect = nil
            self.isProcessing = false
        }
    }

    // MARK: - Next Question
    private func nextQuestion() {

        if currentQuestionIndex < questions.count - 1 {

            currentQuestionIndex += 1
            prepareAnswers()

        } else {

            showResult = true
        }
    }

    // MARK: - Reset
    func resetGame() {

        questions = []
        currentQuestionIndex = 0
        currentAnswers = []
        score = 0
        streak = 0
        showResult = false
        state = .idle
    }
}
