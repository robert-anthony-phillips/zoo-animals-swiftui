//
//  LaunchViewModel.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 31/08/2022.
//

import Foundation

class LaunchViewModel: ObservableObject {

    // MARK: - Properties

    @Published var settings = Settings()

    // MARK: - Dependencies

    var settingsRepository: SettingsRepository

    // MARK: - Lifecycle

    init(settingsRepository: SettingsRepository = SettingsUserDefaultsRepository()) {

        self.settingsRepository = settingsRepository
    }
}

// MARK: - Public

extension LaunchViewModel {

    func writeSettings() {

        Task {
            try await settingsRepository.update(settings)
        }
    }
}
