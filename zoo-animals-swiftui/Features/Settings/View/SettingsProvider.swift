//
//  SettingsRouter.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import SwiftUI

/**
 NOTES:
 I added this class to solve two issues I encountered.
 1. Loading the settings view lazily with the view model instantiated at runtime caused an unwanted animation on the segmented controls. There is a slight delay fetching the settings from UserDefaults which caused the view to be updated whilst it was loading. Instantiating the view model here in advance means that the settings values are available when the settings view is loaded.
 2. I wanted to show the settings view from both the list view and detail view, so adding this small class prevents a small amount of DRY code.
*/

class SettingsProvider: ObservableObject {

    @Published var showSettings = false

    private var viewModel = SettingsViewModel()

    var settingsView: AnyView {

        return AnyView(SettingsView(viewModel: self.viewModel))
    }
}
