//
//  ZooAnimalsApp.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 26/08/2022.
//

import SwiftUI

@main
struct ZooAnimalsApp: App {

    // For a better UX, set to false and bypass the launch screen so that the animal list view loads with the default 10 animals.
    @State var showLaunchView = true

    var body: some Scene {

        WindowGroup {
            if showLaunchView {
                LaunchView(showLaunchView: $showLaunchView)
            } else {
                AnimalListView()
            }
        }
    }
}
