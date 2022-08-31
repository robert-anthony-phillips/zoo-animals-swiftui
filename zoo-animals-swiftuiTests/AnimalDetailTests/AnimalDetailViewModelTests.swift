//
//  AnimalDetailViewModelTests.swift
//  zoo-animals-swiftuiTests
//
//  Created by Robert Phillips on 31/08/2022.
//

import XCTest
@testable import Zoo_Animals

class AnimalDetailViewModelTests: XCTestCase {

    // MARK: - Tests

    func test_readSettings_loadsAndProducesCorrectDisplayValuesForFeetAndPounds() async throws {

        // GIVEN - An instance of AnimalDetailViewModel populated with a settings repo set to feet and pounds.
        let repository = try await makeSettingsRepo(lengthChoice: .feet, weightChoice: .pounds)
        let sut = AnimalDetailViewModel(
            animal: Animal.makePreview(),
            settingsRepository:repository
        )

        // WHEN - We read the settings.
        await sut.readSettings()

        // THEN - We assert that the display values for length and weight are correct.
        XCTAssertEqual(sut.lengthMin, "0.70 ft")
        XCTAssertEqual(sut.lengthMax, "1.10 ft")
        XCTAssertEqual(sut.weightMin, "1.00 lbs")
        XCTAssertEqual(sut.weightMax, "1.50 lbs")
    }

    func test_readSettings_loadsAndProducesCorrectDisplayValuesForCentimetersAndKilograms() async throws {

        // GIVEN - An instance of AnimalDetailViewModel populated with a settings repo set to centimeters and kilograms.
        let repository = try await makeSettingsRepo(lengthChoice: .centimeters, weightChoice: .kilograms)
        let sut = AnimalDetailViewModel(
            animal: Animal.makePreview(),
            settingsRepository:repository
        )

        // WHEN - We read the settings.
        await sut.readSettings()

        // THEN - We assert that the display values for length and weight are correct.
        XCTAssertEqual(sut.lengthMin, "21.34 cm")
        XCTAssertEqual(sut.lengthMax, "33.53 cm")
        XCTAssertEqual(sut.weightMin, "0.45 kg")
        XCTAssertEqual(sut.weightMax, "0.68 kg")
    }

    func test_readSettings_loadsAndProducesCorrectDisplayValuesForMetersAndStones() async throws {

        // GIVEN - An instance of AnimalDetailViewModel populated with a settings repo set to meters and stones.
        let repository = try await makeSettingsRepo(lengthChoice: .meters, weightChoice: .stones)
        let sut = AnimalDetailViewModel(
            animal: Animal.makePreview(),
            settingsRepository:repository
        )

        // WHEN - We read the settings.
        await sut.readSettings()

        // THEN - We assert that the display values for length and weight are correct.
        XCTAssertEqual(sut.lengthMin, "0.21 m")
        XCTAssertEqual(sut.lengthMax, "0.34 m")
        XCTAssertEqual(sut.weightMin, "0.07 st")
        XCTAssertEqual(sut.weightMax, "0.11 st")
    }
}

// MARK: - Helpers

extension AnimalDetailViewModelTests {

    func makeSettingsRepo(
        lengthChoice: LengthChoice,
        weightChoice: WeightChoice
    ) async throws -> SettingsRepository {

        let settings = Settings(
            lengthChoice: lengthChoice,
            weightChoice: weightChoice,
            animalCount: 5
        )

        let repository = SettingsUserDefaultsRepository()

        try await repository.update(settings)

        return repository
    }
}
