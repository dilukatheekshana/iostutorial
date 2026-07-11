//
//  SettingsView.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import SwiftUI

struct SettingsView: View
{

    @StateObject
    private var viewModel = SettingsViewModel()

    @State
    private var showConfirmation = false

    var body: some View
    {

        NavigationStack
        {

            Form
            {

                Section
                {

                    Toggle(
                        "Daily Challenge",
                        isOn: Binding(
                            get:
                            {
                                viewModel.notificationsEnabled
                            },
                            set:
                            {
                                _ in
                                viewModel.toggleNotifications()
                            }
                        )
                    )

                    DatePicker(
                        "Reminder Time",
                        selection: Binding(
                            get:
                            {
                                viewModel.challengeTime
                            },
                            set:
                            {
                                viewModel.challengeTime = $0
                            }
                        ),
                        displayedComponents: .hourAndMinute
                    )

                } header:
                {
                    Text("Notifications")
                }

                Section
                {
                    Button(role: .destructive)
                    {
                        showConfirmation = true
                    } label:
                        {
                            Label(
                            "Reset All Statistics",
                            systemImage: "trash"
                        )

                    }

                }
                header:
                {
                    Text("Statistics")
                }

            }
            .scrollContentBackground(.hidden)
            .background(Color.black)
            .navigationTitle("Settings")
            .preferredColorScheme(.dark)
            .confirmationDialog(
                "Reset all statistics?",
                isPresented: $showConfirmation
            )
            {

                Button(
                    "Reset",
                    role: .destructive
                )
                {
                    viewModel.resetStatistics()
                }

                Button(
                    "Cancel",
                    role: .cancel
                ) {}

            }

        }

    }

}

#Preview
{
    SettingsView()
}
