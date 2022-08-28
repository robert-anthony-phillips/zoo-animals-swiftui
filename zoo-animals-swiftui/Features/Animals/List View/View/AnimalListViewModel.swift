//
//  AnimalListViewModel.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import Foundation

class AnimalListViewModel: ObservableObject {

    @Published var animals = [Animal]()

    var animalRepository: AnimalFetching?

    init(animalRepository: AnimalFetching = AnimalAPI()) {

        self.animalRepository = animalRepository
    }
}

extension AnimalListViewModel {

    func fetchAnimals() async {

        do {
            let result = try await animalRepository?.fetchAnimals(count: 10)
            guard let fetchedAnimals = try result?.get() as? [Animal] else {
                throw AnimalAPIError.noData
            }
            DispatchQueue.main.async {
                self.animals = fetchedAnimals
            }
        } catch {

        }
    }
}
