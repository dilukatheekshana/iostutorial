//
//  SettingsView.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.gray)

                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Coming Soon")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
