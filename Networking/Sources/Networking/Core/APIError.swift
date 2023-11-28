//
//  APIError.swift
//  GihubRepo
//
//  Created by Quang on 25/11/2023.
//

import Foundation

public enum APIError: Error, Equatable {
    /// The URL was invalid.
    case invalidURL

    /// The server response was invalid (unexpected format).
    case invalidResponse

    /// The request was rejected: 400-499
    case badRequest(String?)

    /// Encountered a server error.
    case server(String?)

    /// There was an error parsing the data.
    case decoding(String?)

    /// Unknown error.
    case unknown(String?)
}
