//
//  AnimalRequestType.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 27/08/2022.
//

import Foundation

/**
 NOTES:
 This is also a little over-engineered for the task at hand, but is a demonstration of how I would normally construct a scalable network service.
 Although the values here are duplicated, it demonstrates how I would normally enable the scalability of a service when additional schemes, fetch methods and paths are required that differ for different requests.
*/

/**
 The `RequestType` used by the `AnimalAPI` network service.
*/

extension AnimalAPI {

    enum RequestType {

        case single
        case multiple

        var scheme: String {

            switch self {
            case .single: return "https"
            case .multiple: return "https"
            }
        }

        var httpMethod: String {

            switch self {
            case .single: return "GET"
            case .multiple: return "GET"
            }
        }

        var path: String {

            switch self {
            case .single: return "/animals/rand"
            case .multiple: return "/animals/rand"
            }
        }

        var host: String {

            return "zoo-animal-api.herokuapp.com"
        }
    }
}
