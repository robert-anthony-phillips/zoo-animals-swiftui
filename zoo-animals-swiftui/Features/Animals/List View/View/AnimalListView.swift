//
//  AnimalListView.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import SwiftUI

struct AnimalListView: View {

    @StateObject private var viewModel = AnimalListViewModel()
    @StateObject private var settingsRouter = SettingsRouter()

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
            }
            .listStyle(.inset)
            .navigationTitle("Zoo Animals")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                AnimalListToolBar(
                    viewModel: viewModel,
                    settingsRouter: settingsRouter
                )
            }
            .sheet(isPresented: $settingsRouter.showSettings) {
                SettingsView()
            }
            .refreshable {
                fetchData()
            }
        }
        .onAppear {
            fetchData()
        }
        .environmentObject(settingsRouter)
    }

    func fetchData() {

        Task {
            await viewModel.fetchAnimals()
        }
    }
}

struct AnimalListView_Previews: PreviewProvider {

    static var previews: some View {

        AnimalListView()
    }
}
