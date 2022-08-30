//
//  Settings.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import Foundation

/**
 A Codable object for storing user settings within UserDefaults.
*/

struct Settings: Codable {

    var lengthChoice: LengthChoice = .feet
    var weightChoice: WeightChoice = .pounds
    var animalCount: Int = 10
}

extension Settings {

    static var keyedDefaults: [String: Int] {

        return [
            "lengthChoice": LengthChoice.feet.rawValue,
            "weightChoice": WeightChoice.pounds.rawValue,
            "animalCount": 10
        ]
    }
}
