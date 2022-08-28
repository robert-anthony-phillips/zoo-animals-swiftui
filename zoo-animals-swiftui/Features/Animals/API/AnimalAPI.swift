//
//  AnimalAPI.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 27/08/2022.
//

/**
 NOTES:
 This may be a little over engineered for the task at hand, but gives a good demonstration of how I would normally approach creating the network code to access an API or network service.
 I would normally call `makeURL` from within the `sendDataRequest` method, but this API strangely required the number of required animals as a path component and not as a query argument one would normally expect.
 I therefore also added `pathComponents` as an additional parameter to `makeURL` to accommodate the required animal count as a path component.
 Although not required for this task I have added the `User-Agent` info in the call, which I normally do as it helps with backend debugging incoming requests.
*/

import Foundation

/**
 A class that connects to the zoo animal API service at: https://zoo-animal-api.herokuapp.com
*/

class AnimalAPI {

    // MARK: - Properties

    private var task: Task<AnimalResult, AnimalAPIError>?

    // MARK: - Dependencies

    private let urlSession: URLSession
    private let uaString: String

    // MARK: - Lifecycle

    init(urlSession: URLSession = URLSession.shared,
         uaString: String = UABuilder.uaString) {

        self.urlSession = urlSession
        self.uaString = uaString
    }
}

// MARK: - Public

extension AnimalAPI: AnimalFetching {

    /// Fetches a random single `Animal` object from the API.
    func fetchSingleAnimal() async throws -> AnimalResult {

        let url = try AnimalAPI.makeURL(
            requestType: .single
        )

        return try await sendDataRequest(
            url: url,
            type: .single,
            decodeTo: Animal.self
        )
    }

    /// Fetches multiple random `Animal` objects from the API.
    /// - Parameters:
    ///   - count: The number of random animals required from the API.
    func fetchAnimals(count: Int) async throws -> AnimalResult {

        let url = try AnimalAPI.makeURL(
            pathComponents: ["\(count)"],
            requestType: .multiple
        )

        return try await sendDataRequest(
            url: url,
            type: .multiple,
            decodeTo: Animal.self
        )
    }
}

// MARK: - Private

private extension AnimalAPI {

    /// The generic request that communicates with the Zoo Animals API.
    /// - Parameters:
    ///   - url: The URL the request is sent to.
    ///   - requestType: A RequestType enum that contains all of the values for a specified endpoint.
    ///   - decodeTo: A Decodable object compatible with the expected data.
    func sendDataRequest<T: Decodable>(
        url: URL,
        type: RequestType,
        decodeTo: T.Type
    ) async throws -> AnimalResult {

        let configuration = RequestConfiguration(
            requestType: type,
            uaString: uaString,
            url: url
        )

        task?.cancel()

        let task = Task { () -> AnimalResult in

            let request = try AnimalAPI.makeRequest(with: configuration)

            let (data, response) = try await urlSession.data(for: request)

            guard let urlResponse = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }

            if let error = AnimalAPIError(rawValue: urlResponse.statusCode) {
                return .failure(error)
            }

            if let item = try? JSONDecoder().decode(T.self, from: data) {
                return .success([item])
            }

            if let items = try? JSONDecoder().decode([T].self, from: data) {
                return .success(items)
            }

            return .failure(.noData)
        }

        return try await task.value

    }
}

// MARK: - URL Request

extension AnimalAPI {

    struct RequestConfiguration {

        let requestType: RequestType
        let uaString: String
        let url: URL
    }

    /// Makes a URLRequest specific to the API service..
    /// - Parameters:
    ///   - configuration: The `RequestConfiguration` used to configure the request with various arguments.
    static func makeRequest(with configuration: RequestConfiguration) throws -> URLRequest {

        var request = URLRequest(url: configuration.url)
        request.httpMethod = configuration.requestType.httpMethod

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(configuration.uaString, forHTTPHeaderField: "User-Agent")

        return request
    }
}

// MARK: - URL Components

extension AnimalAPI {

    /// Makes a request URL with optional URLComponents and additional path components.
    /// - Parameters:
    ///   - parameters: An optional parameter map that will be used to construct URL query arguments.
    ///   - pathComponents: An optional String array that will be used to add additional path components.
    ///   - requestType: A RequestType enum that contains all of the values for a specified endpoint.
    static func makeURL(
        parameters: [String: Any]? = nil,
        pathComponents: [String]? = nil,
        requestType: RequestType
    ) throws -> URL {

        var components = URLComponents()
        components.scheme = requestType.scheme
        components.host = requestType.host
        components.path =  requestType.path

        pathComponents?.forEach { component in
            components.path.append("/\(component)")
        }

        components.queryItems = parameters?.sorted { $0.key < $1.key }.map {
            return URLQueryItem(name: $0.key, value: "\($0.value)")
        }

        guard let url = components.url else {
            throw AnimalAPIError.badURL
        }

        return url
    }
}
