//
//  Configuration.swift
//  GihubRepo
//
//  Created by Braly Admin on 27/11/2023.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            fatalError("missing key \(key)")
        }

        switch object {
        case let value as T: return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            print("key: \(value)")
            return value
        default: fatalError("Invalid value for \(key)")
        }
    }
}
