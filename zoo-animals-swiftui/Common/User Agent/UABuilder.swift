//
//  UABuilder.swift
//  zoo-animals-swiftui
//
//  Created by Robert Phillips on 27/08/2022.
//

import UIKit

/**
 A class that enables the construction of `User-Agent` information to be sent with network requests.
*/

protocol UserAgentInfoProviding {

    static var uaString: String { get }
}

class UABuilder {

    // e.g. Darwin/19.3.0
    static var darwinVersion: String {

        var sysinfo = utsname()
        uname(&sysinfo)
        let dv = String(bytes: Data(bytes: &sysinfo.release, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)

        return "Darwin/\(dv)"
    }

    // e.g. CFNetwork/1121.2.2
    static var cfNetworkVersion: String {

        guard
            let dictionary = Bundle(identifier: "com.apple.CFNetwork")?.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String
        else {
            return "CFNetwork/Unknown"
        }

        return "CFNetwork/\(version)"
    }

    // e.g. iOS/13.3.1
    static var deviceVersion: String {

        let currentDevice = UIDevice.current

        return "\(currentDevice.systemName)/\(currentDevice.systemVersion)"
    }

    // e.g. iPhone12,1
    static var deviceName: String {

        var sysinfo = utsname()
        uname(&sysinfo)

        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)?.trimmingCharacters(in: .controlCharacters) ?? "DeviceUnknown"
    }

    // e.g. ZooAnimals/iOS/1.21.49
    static var appNameAndVersion: String {

        guard
            let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String,
            let name = dictionary["CFBundleName"] as? String
        else {
            return "ZooAnimals/Unknown"
        }

        return "\(name)/iOS/\(version)"
    }

    // e.g. 1.21.49
    static func version() -> String {

        guard
            let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String
        else {
            return "Unknown"
        }

        return "\(version)"
    }
}

extension UABuilder: UserAgentInfoProviding {

    static var uaString: String {
        
        return "\(appNameAndVersion) \(deviceName) \(deviceVersion) \(cfNetworkVersion) \(darwinVersion)"
    }
}
