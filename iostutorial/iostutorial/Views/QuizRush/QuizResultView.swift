//
//  QuizResultView.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-02.
//

import SwiftUI

struct QuizResultView: View {

    let score: Int
    let totalQuestions: Int

    @Environment(\.dismiss) private var dismiss

    private var accuracy: Int {
        Int((Double(score) / Double(totalQuestions * 10)) * 100)
    }

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            VStack(spacing: 30) {

                Spacer()

                Image(systemName: score >= 80 ? "crown.fill" : "trophy.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(.yellow)

                Text(score >= 80 ? "Excellent!" : "Quiz Complete!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)

                VStack(spacing: 15) {

                    Text("Final Score")

                    Text("\(score)")
                        .font(.system(size: 55, weight: .bold))

                    Text("Accuracy: \(accuracy)%")

                }
                .foregroundStyle(.white)

                Spacer()

                PrimaryButton(title: "Play Again") {

                    dismiss()

                }

            }
            .padding()

        }

        .navigationBarBackButtonHidden()

    }

}

#Preview {

    QuizResultView(
        score: 75,
        totalQuestions: 10
    )

}
