//
//  JSONFileMapper.swift
//  GihubRepoTests
//
//  Created by Braly Admin on 28/11/2023.
//

import Foundation

struct JSONFileMapper {

    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {

        guard !file.isEmpty,
              let path = Bundle(for: ListRepositoryViewModelTests.self).path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContents
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}

extension JSONFileMapper {
    enum MappingError: Error {
        case failedToGetContents
    }
}
