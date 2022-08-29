//
//  URL+Wikimedia.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import Foundation

extension URL {

    var asWikimediaResizedURL: URL? {

        guard absoluteString.contains("wikimedia") else {
            return self
        }

        let thumbURL = absoluteString.replacingOccurrences(of: "/commons/", with: "/commons/thumb/")
        let url = "\(thumbURL)/320px-\(lastPathComponent)"

        return URL(string: url)
    }
}
