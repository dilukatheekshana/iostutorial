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

            VStack(spacing: 20) {

                Image(systemName: "map.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(.green)

                Text("Map Feature")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Location permission granted ✅")
                    .foregroundStyle(.secondary)

            }
            .navigationTitle("Map")
            .onAppear {
                LocationService.shared.refreshLocation()
            }

        }

    }

}

#Preview {
    MapView()
}
