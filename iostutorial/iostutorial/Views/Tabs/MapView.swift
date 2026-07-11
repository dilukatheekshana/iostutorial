//
//  MapView.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import SwiftUI
import MapKit

struct MapView: View
{

    @StateObject private var viewModel = MapViewModel()
    @State private var camera: MapCameraPosition = .automatic

    var body: some View
    {

        NavigationStack
        {
            
            Group
            {
                if viewModel.sessions.isEmpty
                {
                    ContentUnavailableView(
                        "No Locations Yet",
                        systemImage: "map",
                        description: Text("Finish a game to record your first location.")
                    )
                }
                else
                {
                    Map(position: $camera)
                    {
                        ForEach(viewModel.sessions)
                        {
                            session in
                            Annotation(
                                session.mode.rawValue,
                                coordinate: CLLocationCoordinate2D(
                                    latitude: session.latitude,
                                    longitude: session.longitude
                                )
                            ) {
                                GameMapAnnotation(session: session)
                                    .onTapGesture
                                    {
                                        viewModel.selectedSession = session
                                    }
                            }
                        }
                    }
                }
            }
            
            .navigationTitle("Game Map")
            .onAppear {
                
                viewModel.loadSessions()
                LocationService.shared.refreshLocation()
                
                if let location = LocationService.shared.currentLocation
                {
                    camera = .region(
                        MKCoordinateRegion(
                            center: location.coordinate,
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.05,
                                longitudeDelta: 0.05
                            )
                        )
                    )
                }
            }
            .onReceive(
                NotificationCenter.default.publisher(
                    for: .gameSessionsUpdated
                )
            )
            {
                _ in
                viewModel.loadSessions()
            }
            .sheet(item: $viewModel.selectedSession)
            {
                session in
                SessionDetailView(session: session)
            }
        }
    }
}

#Preview
{
    MapView()
}
