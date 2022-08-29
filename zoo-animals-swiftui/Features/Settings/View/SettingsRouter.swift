//
//  SettingsRouter.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import Foundation

class SettingsRouter: ObservableObject {

    var viewModel = SettingsViewModel()

    @Published var showSettings = false
}
