//
//  AnimalAPIRepository.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 30/08/2022.
//

import Foundation

/**
 A repository that conforms to AnimalRepository capable of retrieving a single or multiple random zoo animals.
 */

class AnimalAPIRepository {

    // MARK: - Dependencies

    var animalFetching: AnimalFetching

    // MARK: - Lifecycle

    init(animalFetching: AnimalFetching = AnimalAPI()) {

        self.animalFetching = animalFetching
    }
}

// MARK: - Public

extension AnimalAPIRepository: AnimalRepository {

    func animal() async throws -> [Animal] {

        let result = try await animalFetching.fetchSingleAnimal()

        guard let animal = try result.get() as? [Animal] else {
            throw AnimalRepositoryError.noData
        }

        return animal
    }

    func animals(count: Int) async throws -> [Animal] {

        let result = try await animalFetching.fetchAnimals(count: count)

        guard let animals = try result.get() as? [Animal] else {
            throw AnimalRepositoryError.noData
        }

        return animals
    }
}
