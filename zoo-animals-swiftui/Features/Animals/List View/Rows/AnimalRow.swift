//
//  AnimalRow.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import SwiftUI

struct AnimalRow: View {

    let viewModel: AnimalRowViewModel

    var body: some View {

        HStack(alignment: .center, spacing: 16) {

            AsyncImage(url: viewModel.thumbnailURL ?? viewModel.imageURL) { image in

                image.resizable()

            } placeholder: {
                Image(
                    systemName: "photo"
                )
                .resizable()
                .foregroundColor(.gray.opacity(0.3))
            }
            .frame(
                width: 78,
                height: 60
            )
            .cornerRadius(5)
            .padding([.top, .bottom], 6)

            VStack(spacing: 4) {

                Text(viewModel.name)
                    .font(.title3)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(viewModel.habitat)
                    .font(.subheadline)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.gray)
            }
        }
    }
}
