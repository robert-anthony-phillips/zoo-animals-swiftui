//
//  AnimalListView.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 28/08/2022.
//

import SwiftUI

struct AnimalListView: View {

    @StateObject private var viewModel = AnimalListViewModel()

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
                AnimalListToolBar(viewModel: viewModel)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchAnimals()
            }
        }
    }
}

struct AnimalListView_Previews: PreviewProvider {

    static var previews: some View {

        AnimalListView()
    }
}
