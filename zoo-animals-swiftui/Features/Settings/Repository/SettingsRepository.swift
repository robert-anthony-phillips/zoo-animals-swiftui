//
//  SettingsRepository.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import Foundation

/**
 A protocol for accessing user settings.
 */

protocol SettingsRepository {

    func read() async throws -> Settings
    func update(_ settings: Settings) async throws
    func delete() async throws
}
