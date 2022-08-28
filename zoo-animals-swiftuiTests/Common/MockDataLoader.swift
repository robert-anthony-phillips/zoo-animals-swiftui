//
//  MockDataLoader.swift
//  zoo-animals-swiftuiTests
//
//  Created by Robert Phillips on 28/08/2022.
//

import XCTest

public typealias JSONMap = [String: Any]
public typealias JSONMapArray = [[String: Any]]

struct MockJSONMap {

    var map: JSONMap
    var rawData: Data
    var stringValue: String
}

struct MockJSONMapArray {

    var mapArray: JSONMapArray
    var rawData: Data
    var stringValue: String
}

class MockDataLoader {

    func loadMapWith(filename: String) async throws -> Result<MockJSONMap?, Error> {

        let data = try await loadFileData(filename: filename)
        let map: JSONMap = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! JSONMap
        let stringValue = try XCTUnwrap(String(data: data, encoding: .utf8))
        let mockJson = MockJSONMap(map: map, rawData: data, stringValue: stringValue)

        return .success(mockJson)
    }

    func loadMapArrayWith(filename: String) async throws -> Result<MockJSONMapArray?, Error> {

        let data = try await loadFileData(filename: filename)
        let mapArray: JSONMapArray = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! JSONMapArray
        let stringValue = try XCTUnwrap(String(data: data, encoding: .utf8))
        let mockJson = MockJSONMapArray(mapArray: mapArray, rawData: data, stringValue: stringValue)

        return .success(mockJson)
    }
}

// MARK: - Helpers

private extension MockDataLoader {

    func loadFileData(filename: String) async throws -> Data {

        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: filename, ofType: "json")
        let filePath = try XCTUnwrap(path)
        let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)

        return data
    }
}
