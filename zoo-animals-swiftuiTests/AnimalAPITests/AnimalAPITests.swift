//
//  AnimalAPITests.swift
//  zoo-animals-swiftuiTests
//
//  Created by Robert Phillips on 28/08/2022.
//

import XCTest
@testable import zoo_animals_swiftui

class AnimalAPITests: XCTestCase {

    // MARK: - Lifecycle

    override func tearDown() {

        super.tearDown()

        MockURLProtocol.requestHandler = nil
    }

    // MARK: - Tests

    func test_fetchSingleAnimal_fetchesAndParsesData() async throws {

        // GIVEN - A mocked URLSession loaded with mocked data
        let urlSession = makeMockURLSession()
        let mockDataResult = try await MockDataLoader().loadMapWith(filename: "Animal")
        let mockData = try XCTUnwrap(mockDataResult.get())
        let jsonString = mockData.stringValue
        setupRequestHandler(responseJSON: jsonString, statusCode: 200)

        // WHEN - We instantiate AnimalAPI and call fetchSingleAnimal.
        let sut = AnimalAPI(urlSession: urlSession)
        let animalResult = try await sut.fetchSingleAnimal()

        // THEN = We assert the fetched result is as expected.
        let animal = try XCTUnwrap((animalResult.get() as? [Animal])?.first)
        XCTAssertEqual(animal.name, "Golden-headed Lion Tamarin")
        XCTAssertEqual(animal.id, 76)
    }

    func test_fetchAnimals_fetchesAndParsesMaxResults() async throws {

        // GIVEN - A mocked URLSession loaded with mocked data
        let urlSession = makeMockURLSession()
        let mockDataResult = try await MockDataLoader().loadMapArrayWith(filename: "Animals")
        let mockData = try XCTUnwrap(mockDataResult.get())
        let jsonString = mockData.stringValue
        setupRequestHandler(responseJSON: jsonString, statusCode: 200)

        // WHEN - We instantiate AnimalAPI and call fetchAnimals.
        let sut = AnimalAPI(urlSession: urlSession)
        let animalResult = try await sut.fetchAnimals(count: 10)
        let animalArray = try XCTUnwrap(animalResult.get() as? [Animal])

        // THEN = We assert the fetched result is as expected.
        let animal = try XCTUnwrap(animalArray.first)
        XCTAssertEqual(animal.name, "Eurasian Eagle Owl")
        XCTAssertEqual(animal.id, 68)
        XCTAssertEqual(animalArray.count, 10)
    }
}

// MARK: - Helpers

extension AnimalAPITests {

    func setupRequestHandler(responseJSON: String, statusCode: Int) {

        let headers = [
            "Content-Type": "application/json",
        ]

        let responseData = responseJSON.data(using: .utf8)

        MockURLProtocol.requestHandler = { request in

            guard let url = request.url else {
                throw AnimalAPIError.invalidRequest
            }

            let response = HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: headers
            )!

            return (response, responseData)
        }
    }

    func makeMockURLSession() -> URLSession {

        // Create a mock URLSession to inject into UserMetadataService
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        return urlSession
    }
}
