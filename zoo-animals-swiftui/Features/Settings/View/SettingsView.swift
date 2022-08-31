//
//  SettingsView.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import SwiftUI

struct SettingsView: View {

    // MARK: - Properties

    @StateObject var viewModel: SettingsViewModel

    @Environment(\.dismiss) var dismiss

    // MARK: - View

    var body: some View {

        NavigationView {

            VStack(alignment: .leading, spacing: 16) {

                VStack(alignment: .leading, spacing: 4) {

                    let title = "Length unit"

                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(.accentColor)

                    Picker(title, selection: $viewModel.settings.lengthChoice) {
                        ForEach(LengthChoice.allCases, id: \.self) {
                            Text($0.displayText)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                VStack(alignment: .leading, spacing: 4) {

                    let title = "Weight unit"

                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(.accentColor)

                    Picker(title, selection: $viewModel.settings.weightChoice) {
                        ForEach(WeightChoice.allCases, id: \.self) {
                            Text($0.displayText)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                VStack(alignment: .leading, spacing: 4) {

                    let title = "Number of random animals"

                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(.accentColor)

                    Picker(title, selection: $viewModel.settings.animalCount) {
                        ForEach((1..<11).indices, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                }
            }
        }
    }
}

// MARK: - PreviewProvider

struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {

        SettingsView(viewModel: SettingsViewModel())
    }
}
