//
//  LaunchView.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 31/08/2022.
//

import SwiftUI

struct LaunchView: View {

    // MARK: - Properties

    @Binding var showLaunchView: Bool
    @StateObject private var viewModel = LaunchViewModel()

    // MARK: - View

    var body: some View {

        NavigationView {

            VStack(alignment: .center, spacing: 16) {

                Text("Welcome to Zoo Animals")
                    .font(.title)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)

                Text("Please select the number of random animals you would like to display.")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)

                Divider()

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

                Button(action: {

                    viewModel.writeSettings()
                    showLaunchView = false

                }) {
                    Text("Save")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 100)
                        .padding([.top, .bottom], 10)
                        .padding([.leading, .trailing], 16)
                }
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(40)
                .padding(.top)

                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - PreviewProvider

struct LaunchView_Previews: PreviewProvider {

    static var previews: some View {

        LaunchView(showLaunchView: .constant(false))
    }
}
