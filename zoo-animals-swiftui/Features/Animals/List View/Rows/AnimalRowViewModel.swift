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

        let url = URL(string: animal.imageLink ?? "")

        return url?.asWikimediaResizedURL ?? url
    }

    var name: String {

        animal.name ?? "Unknown"
    }

    var habitat: String {

        animal.habitat ?? "Unknown"
    }
}
