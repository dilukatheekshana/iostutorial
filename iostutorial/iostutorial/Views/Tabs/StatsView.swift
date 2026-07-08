//
//  StatsView.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)

                Text("Stats")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Coming Soon")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Stats")
        }
    }
}

#Preview {
    StatsView()
}
