//
//  SettingType.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import Foundation

enum SettingType: String {

    case lengthChoice
    case weightChoice
    case animalCount
}

extension SettingType: DefaultReadable {

    var defaultValue: Int {

        switch self {
        case .lengthChoice: return LengthChoice.feet.rawValue
        case .weightChoice: return WeightChoice.pounds.rawValue
        case .animalCount: return 10
        }
    }
}
