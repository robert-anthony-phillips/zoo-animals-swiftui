//
//  DefaultReadable.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 29/08/2022.
//

import Foundation

protocol DefaultReadable: CaseIterable {

    associatedtype T

    /// Returns the default value of an associated enum
    var defaultValue: T { get }
}

extension DefaultReadable where Self: RawRepresentable, Self.RawValue == String {

    /// Returns a string value dictionary for all of the keys and default values defined for an associated enum
    static var keyedDefaults: [String: Any] {

        return Dictionary(uniqueKeysWithValues: Self.allCases.lazy.map { ($0.rawValue, $0.defaultValue as Any) })
    }
}
