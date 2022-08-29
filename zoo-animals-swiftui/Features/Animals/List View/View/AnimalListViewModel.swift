//
//  AnimalListViewModel.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import Foundation

class AnimalListViewModel: ObservableObject {

    @Published var animals = [Animal]()
    @Published var showSettings = false

    var animalRepository: AnimalFetching
    var settingsRepository: SettingsRepository

    init(animalRepository: AnimalFetching = AnimalAPI(),
         settingsRepository: SettingsRepository = SettingsUserDefaultsRepository()) {

        self.animalRepository = animalRepository
        self.settingsRepository = settingsRepository
    }
}

extension AnimalListViewModel {

    func fetchAnimals() async {

        do {
            let settings = try await settingsRepository.read()
            let result = try await animalRepository.fetchAnimals(count: settings.animalCount)
            guard let fetchedAnimals = try result.get() as? [Animal] else {
                throw AnimalAPIError.noData
            }
            DispatchQueue.main.async {
                self.animals = fetchedAnimals
            }
        } catch {
            
        }
    }
}
