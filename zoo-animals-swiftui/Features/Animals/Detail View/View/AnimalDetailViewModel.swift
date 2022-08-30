//
//  AnimalDetailViewModel.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import Foundation

class AnimalDetailViewModel: ObservableObject {

    // MARK: - Properties

    let animal: Animal

    @Published var lengthMin = "Unknown"
    @Published var lengthMax = "Unknown"
    @Published var weightMin = "Unknown"
    @Published var weightMax = "Unknown"

    var settingsRepository: SettingsRepository

    var imageURL: URL? {

        let url = URL(string: animal.imageLink ?? "")

        return url?.asWikimediaResizedURL ?? url
    }

    var name: String {

        guard
            let name = animal.name,
            let latinName = animal.latinName
        else {
            return animal.name ?? "Name unknown"
        }

        return "\(name) (\(latinName))"
    }

    var diet: String {

        animal.diet ?? "Unknown"
    }

    // MARK: - Lifecycle

    init(animal: Animal,
         settingsRepository: SettingsRepository = SettingsUserDefaultsRepository()
    ) {
        self.animal = animal
        self.settingsRepository = settingsRepository
    }
}

// MARK: - Public

extension AnimalDetailViewModel {

    func readSettings() async {

        let settings = try? await settingsRepository.read()

        lengthMin = lengthDisplay(length: animal.lengthMin, choice: settings?.lengthChoice ?? .feet)
        lengthMax = lengthDisplay(length: animal.lengthMax, choice: settings?.lengthChoice ?? .feet)

        weightMin = weightDisplay(weight: animal.weightMin, choice: settings?.weightChoice ?? .pounds)
        weightMax = weightDisplay(weight: animal.weightMax, choice: settings?.weightChoice ?? .pounds)
    }
}

// MARK: - Private

private extension AnimalDetailViewModel {

    func weightDisplay(weight: String?, choice: WeightChoice) -> String {

        let displayUnit = choice.displayUnit

        guard let weight = weight else {
            return "Unknown"
        }

        guard let doubleValue = Double(weight) else {
            return "\(weight) \(displayUnit)"
        }

        let converted = doubleValue * choice.multiplier
        return "\(String(format: "%.2f", converted)) \(displayUnit)"
    }

    func lengthDisplay(length: String?, choice: LengthChoice) -> String {

        let displayUnit = choice.displayUnit

        guard let length = length else {
            return "Unknown"
        }

        guard let doubleValue = Double(length) else {
            return "\(length) \(displayUnit)"
        }

        let converted = doubleValue * choice.multiplier
        return "\(String(format: "%.2f", converted)) \(displayUnit)"
    }
}
