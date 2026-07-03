//
//  QuizRushView.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-02.
//

import SwiftUI

struct QuizRushView: View {

    @ObservedObject var viewModel: QuizRushViewModel

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            Text("Quiz Screen Coming Soon")
                .font(.title)
                .foregroundStyle(.white)

        }

    }

}

#Preview {
    QuizRushView(
        viewModel: QuizRushViewModel()
    )
}
