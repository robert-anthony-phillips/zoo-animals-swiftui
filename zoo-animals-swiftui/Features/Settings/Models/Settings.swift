//
//  Settings.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import Foundation

class Settings: Codable {

    var lengthChoice: LengthChoice = .feet
    var weightChoice: WeightChoice = .pounds
    var animalCount: Int = 10
}
