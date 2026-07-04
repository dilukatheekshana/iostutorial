import Foundation
import SwiftUI
internal import Combine

@MainActor
class QuizRushViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var questions: [TriviaQuestion] = []

    @Published var currentQuestionIndex = 0

    @Published var score = 0

    @Published var streak = 0

    @Published var state: QuizViewState = .idle

    @Published var gameFinished = false
    
    @Published var correctAnswers = 0
    
    @Published var answers: [String] = []

    @Published var selectedAnswer: String?

    @Published var answerSubmitted = false
    
    @AppStorage("quizHighScore") var highScore: Int = 0
    @Published var showFlash = false
    @Published var flashIsCorrect = false

    // MARK: - API Service

    private let apiService = TriviaAPIService()

    // MARK: - Computed Property

    var currentQuestion: TriviaQuestion? {
        guard currentQuestionIndex < questions.count else {
            return nil
        }

        return questions[currentQuestionIndex]
    }
    
    private func prepareAnswers() {

        guard let question = currentQuestion else {
            return
        }

        answers = ([question.correctAnswer] + question.incorrectAnswers)
            .map { $0.htmlDecoded }
            .shuffled()

    }

    // MARK: - Load Questions

    func loadQuestions(category: Int?, difficulty: String?) async {

        state = .loading
        gameFinished = false

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

            state = .failed(
                "Unable to load questions.\nPlease check your internet connection."
            )

        }
    }

    // MARK: - Answer Question

    func answerQuestion(selectedAnswer: String) {
        

        guard !answerSubmitted else {
            return
        }

        guard let question = currentQuestion else {
            return
        }
        
        showFlash = true
        flashIsCorrect = selectedAnswer == question.correctAnswer.htmlDecoded
        
        self.selectedAnswer = selectedAnswer
        answerSubmitted = true

        if selectedAnswer == question.correctAnswer.htmlDecoded {

            correctAnswers += 1

            score += 10
            streak += 1

            if streak >= 3 {
                score += 5
            }

            if score > highScore {
                highScore = score
            }

        } else {

            score = max(score - 2, 0)

            streak = 0

        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {

            self.showFlash = false
            self.moveToNextQuestion()

        }

    }

    // MARK: - Next Question

    private func moveToNextQuestion() {

        answerSubmitted = false
        selectedAnswer = nil

        if currentQuestionIndex < questions.count - 1 {

            currentQuestionIndex += 1

            prepareAnswers()

        } else {

            gameFinished = true

        }

    }

    // MARK: - Restart Game

    func resetGame() {

        questions.removeAll()

        answers.removeAll()

        currentQuestionIndex = 0

        score = 0

        streak = 0

        selectedAnswer = nil

        answerSubmitted = false

        gameFinished = false

        state = .idle
        
        correctAnswers = 0

    }
    
    var accuracy: Int {

        guard !questions.isEmpty else {

            return 0

        }

        return Int((Double(correctAnswers) / Double(questions.count)) * 100)

    }

}
