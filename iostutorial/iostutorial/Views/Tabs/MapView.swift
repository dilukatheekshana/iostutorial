//
//  MapView.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "map.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.green)

                Text("Map")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Coming Soon")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Map")
        }
    }
}

#Preview {
    MapView()
}
