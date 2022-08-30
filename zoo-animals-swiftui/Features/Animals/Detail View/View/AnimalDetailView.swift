//
//  AnimalDetailView.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import SwiftUI

struct AnimalDetailView: View {

    // MARK: - Properties

    @StateObject var viewModel: AnimalDetailViewModel
    @StateObject private var settingsProvider = SettingsProvider()

    // MARK: - View

    var body: some View {

        ScrollView {

            VStack(alignment: .center, spacing: 16) {

                AsyncImage(url: viewModel.imageURL) { image in

                    image.resizable()

                } placeholder: {
                    Image(
                        systemName: "photo"
                    )
                    .resizable()
                    .foregroundColor(.gray.opacity(0.2))
                }
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
                .shadow(radius: 1)

                VStack(spacing: 4) {

                    Text(viewModel.name)
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 6)

                    Divider().padding([.top, .bottom], 6)

                    AnimalDetailRow(title: "Diet", detail: viewModel.diet)

                    Divider().padding([.top, .bottom], 6)

                    AnimalDetailRow(title: "Min length", detail: viewModel.lengthMin)
                    AnimalDetailRow(title: "Max length", detail: viewModel.lengthMax)

                    Divider().padding([.top, .bottom], 6)

                    AnimalDetailRow(title: "Min weight", detail: viewModel.weightMin)
                    AnimalDetailRow(title: "Max weight", detail: viewModel.weightMax)
                }
            }
            .padding()
            .sheet(isPresented: $settingsProvider.showSettings, onDismiss: {
                readSettings()
            }, content: {
                settingsProvider.settingsView
            })

        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    settingsProvider.showSettings = true
                } label: {
                    Image(systemName: "gearshape")
                }
            }
        }
        .onAppear {
            readSettings()
        }
    }
}

// MARK: - Private

private extension AnimalDetailView {

    func readSettings() {

        Task {
            await viewModel.readSettings()
        }
    }
}

// MARK: - PreviewProvider

struct AnimalDetailView_Previews: PreviewProvider {

    static var previews: some View {

        AnimalDetailView(
            viewModel: AnimalDetailViewModel(
                animal: Animal.makePreview()
            )
        )
    }
}
