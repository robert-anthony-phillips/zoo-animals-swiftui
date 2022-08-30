//
//  LengthChoice.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import Foundation

/**
 An enumeration of the user length choices for display within the detail view.
*/

enum LengthChoice: Int, Codable, CaseIterable {

    case feet
    case centimeters
    case meters

    var displayUnit: String {

        switch self {
        case .feet: return "ft"
        case .centimeters: return "cm"
        case .meters: return "m"
        }
    }

    var displayText: String {

        switch self {
        case .feet: return "Feet (ft)"
        case .centimeters: return "Centimetres (cm)"
        case .meters: return "Metres (m)"
        }
    }

    var multiplier: Double {

        switch self {
        case .feet: return 1
        case .centimeters: return 30.48
        case .meters: return 0.3048
        }
    }
}
