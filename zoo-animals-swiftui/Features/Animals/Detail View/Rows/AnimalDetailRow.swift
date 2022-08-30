//
//  AnimalDetailRow.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import SwiftUI

struct AnimalDetailRow: View {

    // MARK: - Properties

    let title: String
    let detail: String

    // MARK: - View

    var body: some View {

        HStack(alignment: .top) {

            Text("\(title):")
                .font(.body)
                .frame(maxWidth: 100, alignment: .leading)
                .foregroundColor(.accentColor)

            Text(detail)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
        }
    }
}
