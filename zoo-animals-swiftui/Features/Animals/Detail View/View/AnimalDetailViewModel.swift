//
//  AnimalDetailViewModel.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import Foundation

struct AnimalDetailViewModel {

    let animal: Animal

    var imageURL: URL? {

        URL(string: animal.imageLink ?? "")
    }

    var thumbnailURL: URL? {

        guard
            let imageLink = animal.imageLink,
            let filename = imageURL?.lastPathComponent
        else {
            return nil
        }

        let thumbURL = imageLink.replacingOccurrences(of: "/commons/", with: "/commons/thumb/")
        let url = "\(thumbURL)/320px-\(filename)"

        return URL(string: url)
    }

    var name: String {

        guard
            let name = animal.name,
            let latinName = animal.latinName
        else {
            return animal.name ?? "Name unknown"
        }

        return "\(name) (\(latinName))"
    }

    var diet: String {

        animal.diet ?? "Unknown"
    }

    var lengthMin: String {

        animal.lengthMin ?? "Unknown"
    }

    var lengthMax: String {

        animal.lengthMax ?? "Unknown"
    }

    var weightMin: String {

        animal.weightMin ?? "Unknown"
    }

    var weightMax: String {

        animal.weightMax ?? "Unknown"
    }
}
