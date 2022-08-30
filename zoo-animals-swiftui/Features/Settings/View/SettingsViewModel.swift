//
//  SettingsViewModel.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import Foundation

class SettingsViewModel: ObservableObject {

    // MARK: - Properties

    @Published var settings = Settings() {
        didSet {
            writeSettings()
        }
    }

    var isWriteAllowed = false

    // MARK: - Dependencies

    var settingsRepository: SettingsRepository

    // MARK: - Lifecycle

    init(settingsRepository: SettingsRepository = SettingsUserDefaultsRepository()) {

        self.settingsRepository = settingsRepository

        Task {
            await readSettings()
        }
    }
}

// MARK: - Private

private extension SettingsViewModel {

    func readSettings() async {

        guard let settings = try? await settingsRepository.read() else {
            isWriteAllowed = true
            return
        }

        DispatchQueue.main.async { [weak self] in
            
            self?.settings = settings
            self?.isWriteAllowed = true
        }
    }

    func writeSettings() {

        guard isWriteAllowed else { return }

        Task {
            try await settingsRepository.update(settings)
        }
    }
}
