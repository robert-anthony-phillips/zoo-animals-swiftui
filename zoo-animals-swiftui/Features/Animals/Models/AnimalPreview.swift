//
//  AnimalPreview.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import Foundation

extension Animal {

    static func makePreview() -> Animal {

        Animal(
            name: "Golden-headed Lion Tamarin",
            latinName: "Leontopithecus chrysomelas",
            animalType: "Mammal",
            activeTime: "Diurnal",
            lengthMin: "0.7",
            lengthMax: "1.1",
            weightMin: "1",
            weightMax: "1.5",
            lifespan: "11",
            habitat: "Tropical rainforest",
            diet: "Fruit, flowers, nectar, gum and small animals",
            geoRange: "Eastern Brazil",
            imageLink: "https://upload.wikimedia.org/wikipedia/commons/3/3d/Leontopithecus_chrysomelas_%28portrait%29.jpg",
            id: 76
        )
    }
}
