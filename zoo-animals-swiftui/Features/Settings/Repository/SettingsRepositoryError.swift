//
//  SettingsRepositoryError.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import Foundation

enum SettingsRepositoryError: Error {

    case unknown
    case readFailed
    case updateFailed
    case deleteFailed
}
