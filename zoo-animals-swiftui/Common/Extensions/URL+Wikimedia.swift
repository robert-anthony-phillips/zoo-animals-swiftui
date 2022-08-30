//
//  URL+Wikimedia.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import Foundation

/**
 NOTES:
 The image URLs provided by the Animals API were too large and slow to load. As most of them were provided by `wikimedia` who provide the ability to add query parameters to the URL, this URL extension returns a substitute URL that resizes all images down to 320 points. This could be viewed as tightly coupling the view models to the `wikimedia` service, but the extension will fail gracefully in the event that the service was changed and future developers failed to notice the use of the extension, but I think it's worth it for the improvement in load times and UX.
*/

extension URL {

    var asWikimediaResizedURL: URL? {

        guard absoluteString.contains("wikimedia") else {
            return self
        }

        let thumbURL = absoluteString.replacingOccurrences(of: "/commons/", with: "/commons/thumb/")
        let url = "\(thumbURL)/320px-\(lastPathComponent)"
            .removingPercentEncoding?
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? absoluteString

        return URL(string: url)
    }
}
