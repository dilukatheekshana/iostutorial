import SwiftUI

struct QuizSetupView: View
{

    @StateObject private var viewModel = QuizRushViewModel()

    @State private var selectedCategory: TriviaCategory? = TriviaCategory.all.first

    @State private var selectedDifficulty = "easy"

    @State private var startQuiz = false

    private let difficulties = [
        "easy",
        "medium",
        "hard"
    ]
    
    init()
    {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.white

        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .normal
        )

        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.black],
            for: .selected
        )
    }

    var body: some View
    {

        ZStack
        {

            Color.black
                .ignoresSafeArea()

            VStack(spacing: 25)
            {

                Spacer()

                VStack(spacing: 8)
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.indigo)
                            .frame(width: 100, height: 100)
                            
                        Image(systemName: "book.pages")
                            .font(Font.system(size: 60, weight: .bold, design: .rounded))
                    }
                    

                    Text("Quiz Rush")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.indigo)

                    Text("Test Your Knowledge")
                        .foregroundStyle(.gray)

                }

                SectionCard(title: "Category")
                {

                    Picker("Category", selection: $selectedCategory)
                    {
                        ForEach(TriviaCategory.all) { category in

                            Text(category.name)
                                .tag(category as TriviaCategory?)

                        }
                    }
                    .pickerStyle(.menu)
                    .tint(Color.indigo)

                }

                SectionCard(title: "Difficulty")
                {

                    Picker("Difficulty", selection: $selectedDifficulty)
                    {

                        ForEach(difficulties, id: \.self)
                        {
                            difficulty in

                            Text(difficulty.capitalized)
                                .tag(difficulty)  

                        }

                    }
                    .pickerStyle(.segmented)

                }

                PrimaryButton(title: "Start Quiz")
                {

                    Task
                    {

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
                    Text("View High Score")
                        .foregroundStyle(.white)
                }

                Spacer()

                    .navigationDestination(isPresented: $startQuiz)
                    {
                        QuizRushView(viewModel: viewModel)
                    }

            }
            .padding()

        }
        .toolbar(.hidden, for: .tabBar)

    }

}

#Preview
{
    QuizSetupView()
}
