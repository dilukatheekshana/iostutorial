import Foundation

struct TriviaAPIService {

    func fetchQuestions(category: Int?, difficulty: String?) async throws -> [TriviaQuestion] {

        var urlString = "https://opentdb.com/api.php?amount=10&type=multiple"

        // Add category if selected
        if let category = category {
            urlString += "&category=\(category)"
        }

        // Add difficulty if selected
        if let difficulty = difficulty {
            urlString += "&difficulty=\(difficulty.lowercased())"
        }

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()

        let response = try decoder.decode(TriviaResponse.self, from: data)

        return response.results
    }

}
