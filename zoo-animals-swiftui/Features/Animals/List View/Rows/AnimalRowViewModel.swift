//
//  AnimalRowViewModel.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import Foundation

struct AnimalRowViewModel {

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

        animal.name ?? "Unknown"
    }

    var habitat: String {

        animal.habitat ?? "Unknown"
    }
}
