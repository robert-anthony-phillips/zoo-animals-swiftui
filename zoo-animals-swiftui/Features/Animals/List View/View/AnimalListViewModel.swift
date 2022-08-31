//
//  AnimalListViewModel.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import Foundation

class AnimalListViewModel: ObservableObject {

    // MARK: - Properties

    @Published var animals = [Animal]()
    @Published var showFetchAlert = false

    var showAnimalCountAlert = true

    // MARK: - Dependencies

    var animalRepository: AnimalRepository
    var settingsRepository: SettingsRepository

    // MARK: - Lifecycle

    init(animalRepository: AnimalRepository = AnimalAPIRepository(),
         settingsRepository: SettingsRepository = SettingsUserDefaultsRepository()
    ) {
        self.animalRepository = animalRepository
        self.settingsRepository = settingsRepository
    }
}

// MARK: - Public

extension AnimalListViewModel {

    func fetchAnimals() async {

        do {
            let settings = try await settingsRepository.read()
            let animals = try await animalRepository.animals(count: settings.animalCount)
            DispatchQueue.main.async { [weak self] in
                self?.animals = animals
            }
        } catch {
            showFetchAlert = true
        }
    }
}
