//
//  AnimalListToolbar.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import SwiftUI

struct AnimalListToolBar: ToolbarContent {

    // MARK: - Properties

    let viewModel: AnimalListViewModel
    let settingsProvider: SettingsProvider

    // MARK: - ToolbarContent

    var body: some ToolbarContent {

        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                Task {
                    await viewModel.fetchAnimals()
                }
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath")
            }
        }

        ToolbarItem(placement: .navigationBarTrailing) {

            Button {
                settingsProvider.showSettings = true
            } label: {
                Image(systemName: "gearshape")
            }
        }
    }
}
