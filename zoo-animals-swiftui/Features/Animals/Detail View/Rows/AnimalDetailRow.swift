//
//  AnimalDetailRow.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import SwiftUI

struct AnimalDetailRow: View {

    let title: String
    let detail: String

    var body: some View {

        HStack(alignment: .top) {

            Text("\(title):")
                .font(.headline)
                .frame(maxWidth: 100, alignment: .leading)
                .foregroundColor(.accentColor)

            Text(detail)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
        }
    }
}
