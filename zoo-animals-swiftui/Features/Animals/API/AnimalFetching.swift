//
//  AnimalFetching.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 27/08/2022.
//

import Foundation

/**
 The protocol for publicly accessing the AnimalAPI network service.
*/

protocol AnimalFetching {

    typealias AnimalResult = Result<[Decodable], AnimalAPIError>

    func fetchSingleAnimal() async throws -> AnimalResult
    func fetchAnimals(count: Int) async throws -> AnimalResult
}
