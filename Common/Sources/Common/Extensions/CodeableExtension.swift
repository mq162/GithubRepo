//
//  CodeableExtension.swift
//  GihubRepo
//
//  Created by Braly Admin on 25/11/2023.
//

import Foundation

extension JSONDecoder {

    public static let apiDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}


extension JSONEncoder {

    public static let apiEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()

}
