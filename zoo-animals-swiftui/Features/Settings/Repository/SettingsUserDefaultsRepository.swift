//
//  SettingsUserDefaultsRepository.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import Foundation

class SettingsUserDefaultsRepository {

    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    let defaults = UserDefaults.standard

    init() {

        setDefaults()
    }
}

// MARK: - Public

extension SettingsUserDefaultsRepository: SettingsRepository {

    func read() async throws -> Settings {

        guard let data = defaults.value(forKey: UserDefaultsKey.settings) as? Data else {
            return Settings()
        }

        do {
            let settings = try decoder.decode(Settings.self, from: data)
            return settings
        } catch {
            throw SettingsRepositoryError.readFailed
        }
    }

    func update(_ settings: Settings) async throws {

        guard let data = try? encoder.encode(settings) else {
            throw SettingsRepositoryError.updateFailed
        }

        defaults.set(data, forKey: UserDefaultsKey.settings)
    }

    func delete() async throws {

        defaults.removeObject(forKey: UserDefaultsKey.settings)
    }
}

// MARK: - Private

private extension SettingsUserDefaultsRepository {

    func setDefaults() {

        UserDefaults.standard.register(defaults: SettingType.keyedDefaults)
    }
}
