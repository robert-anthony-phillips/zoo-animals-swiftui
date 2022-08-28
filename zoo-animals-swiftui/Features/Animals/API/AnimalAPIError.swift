//
//  AnimalAPIError.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 27/08/2022.
//

import Foundation

/**
 NOTES:
 There are errors listed here that are not included in the implementation, but demonstrates how I would normally construct custom errors for a network service.
 I often choose to implement `CustomNSError` as this is more compatible with certain crash reporting services such as `Crashlytics`.
*/

public enum AnimalAPIError: Int {

    case unknown
    case badURL
    case noData
    case invalidResponse
    case invalidRequest = 400
    case notAuthenticated = 401
    case unauthorized = 403
    case serverError = 500
}

extension AnimalAPIError: CustomNSError {

    /// return the error domain
    public static var errorDomain: String { return "com.herokuapp.zoo-animal-api" }

    /// return the error code
    public var errorCode: Int { return self.rawValue }

    /// return the userInfo
    public var errorUserInfo: [String: Any] {
        switch self {
        case .unknown:
            return [NSLocalizedDescriptionKey: "There was an unknown error."]
        case .badURL:
            return [NSLocalizedDescriptionKey: "Could not create the API URL."]
        case .noData:
            return [NSLocalizedDescriptionKey: "No data was returned from the API"]
        case .invalidResponse:
            return [NSLocalizedDescriptionKey: "Invalid response."]
        case .invalidRequest:
            return [NSLocalizedDescriptionKey: "Invalid request."]
        case .notAuthenticated:
            return [NSLocalizedDescriptionKey: "User was not authenticated."]
        case .unauthorized:
            return [NSLocalizedDescriptionKey: "The API token was invalid or the server denied permission."]
        case .serverError:
            return [NSLocalizedDescriptionKey: "Internal server error."]
        }
    }
}
