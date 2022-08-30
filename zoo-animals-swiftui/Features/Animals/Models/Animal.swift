//
//  Animal.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 27/08/2022.
//

import Foundation

/**
 NOTES:
 I will often add an additional object as the domain object in addition to the DTO, but intentionally decided to use the same object for both for this simple demonstration.
*/

struct Animal: Decodable {

    let name: String?
    let latinName: String?
    let animalType: String?
    let activeTime: String?
    let lengthMin: String?
    let lengthMax: String?
    let weightMin: String?
    let weightMax: String?
    let lifespan: String?
    let habitat: String?
    let diet: String?
    let geoRange: String?
    let imageLink: String?
    let id: Int?

    private enum CodingKeys: String, CodingKey {

        case name
        case latinName = "latin_name"
        case animalType = "animal_type"
        case activeTime = "active_time"
        case lengthMin = "length_min"
        case lengthMax = "length_max"
        case weightMin = "weight_min"
        case weightMax = "weight_max"
        case lifespan
        case habitat
        case diet
        case geoRange = "geo_range"
        case imageLink = "image_link"
        case id
    }
}
