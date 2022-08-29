//
//  WeightChoice.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import Foundation

enum WeightChoice: Int, Codable, CaseIterable {

    case pounds
    case kilograms
    case stones

    var displayUnit: String {

        switch self {
        case .pounds: return "lbs"
        case .kilograms: return "kg"
        case .stones: return "st"
        }
    }

    var multiplier: Double {

        switch self {
        case .pounds: return 1
        case .kilograms: return 0.453592
        case .stones: return 0.0714286
        }
    }
}
