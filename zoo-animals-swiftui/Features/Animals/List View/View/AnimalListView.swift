//
//  AnimalListView.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import SwiftUI

struct AnimalListView: View {

    // MARK: - Properties

    @StateObject private var viewModel = AnimalListViewModel()
    @StateObject private var settingsProvider = SettingsProvider()

    // MARK: - View

    var body: some View {

        NavigationView {

            List(viewModel.animals, id: \.id) { animal in
                NavigationLink(
                    destination: AnimalDetailView(
                        viewModel: AnimalDetailViewModel(animal: animal)
                    )
                ) {
                    AnimalRow(
                        viewModel: AnimalRowViewModel(animal: animal)
                    )
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Zoo Animals")
            }
            .listStyle(.inset)
            .toolbar {
                AnimalListToolBar(
                    viewModel: viewModel,
                    settingsProvider: settingsProvider
                )
            }
            .sheet(isPresented: $settingsProvider.showSettings) {
                settingsProvider.settingsView
            }
            .refreshable {
                fetchData()
            }
        }
        .onAppear {
            fetchData()
        }
        .alert(isPresented: $viewModel.showFetchAlert) {
            Alert(
                title: Text("Oops!"),
                message: Text("We were unable to find any animals for you. Please try again later."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

// MARK: - Private

private extension AnimalListView {

    func fetchData() {

        Task {
            await viewModel.fetchAnimals()
        }
    }
}

// MARK: - PreviewProvider

struct AnimalListView_Previews: PreviewProvider {

    static var previews: some View {

        AnimalListView()
    }
}
