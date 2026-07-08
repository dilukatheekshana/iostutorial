//
//  ScoreBadge.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import SwiftUI

struct ScoreBadge: View {

    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {

        VStack(spacing: 12) {

            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundStyle(color)

            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)

            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)

        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6).opacity(0.15))
        .cornerRadius(18)
    }
}

#Preview {

    ZStack {

        Color.black
            .ignoresSafeArea()

        ScoreBadge(
            title: "Highest Score",
            value: "48",
            icon: "trophy.fill",
            color: .yellow
        )
        .padding()

    }
}
