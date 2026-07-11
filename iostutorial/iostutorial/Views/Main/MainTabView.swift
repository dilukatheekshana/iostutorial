//
//  MainTabView.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import SwiftUI

struct MainTabView: View
{

    var body: some View
    {

        TabView
        {

            NavigationStack
            {
                HomeView()
            }
                 .tabItem
                {
                     Label("Home", systemImage: "house.fill")
                }

            StatsView()
                .tabItem
                {
                    Label("Stats", systemImage: "chart.bar.fill")
                }

            MapView()
                .tabItem
                {
                    Label("Map", systemImage: "map.fill")
                }

            SettingsView()
                .tabItem
                {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview
{
    
    MainTabView()
}
