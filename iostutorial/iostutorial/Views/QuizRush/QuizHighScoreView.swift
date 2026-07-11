import SwiftUI

struct QuizHighScoreView: View
{

    @ObservedObject var viewModel: QuizRushViewModel

    @Environment(\.dismiss) private var dismiss

    var body: some View
    {

        ZStack
        {

            Color.black.ignoresSafeArea()

            VStack(spacing: 30)
            {

                Spacer()

                ZStack
                {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.indigo)
                        .frame(width: 100, height: 100)
                        
                    Image(systemName: "trophy.fill")
                        .font(Font.system(size: 60, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.black)
                }

                VStack(spacing: 20)
                {

                    VStack
                    {

                        Text("Best Score")
                            .foregroundStyle(.gray)

                        Text("\(viewModel.highScore)")
                            .font(.system(size: 50))
                            .bold()
                            .foregroundStyle(.yellow)

                    }

                }

                Spacer()

                PrimaryButton(title: "Back")
                {
                    dismiss()
                }

            }
            .padding()

        }

    }
}
