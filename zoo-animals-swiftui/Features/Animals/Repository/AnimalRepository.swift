//
//  AnimalRepository.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 30/08/2022.
//

import Foundation

/**
 A protocol for accessing randomly generated animals.
 */

protocol AnimalRepository {

    func animal() async throws -> [Animal]
    func animals(count: Int) async throws -> [Animal]
}
