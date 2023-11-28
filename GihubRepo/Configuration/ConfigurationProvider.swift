//
//  ConfigurationProvider.swift
//  GihubRepo
//
//  Created by Quang on 26/11/2023.
//

import Foundation
import Networking

enum ConfigurationProvider: APIConfigProtocol {
    case githubAPI
    
    enum Keys {
        static let githubToken = "GITHUB_TOKEN"
    }
    
    enum Paths {
        static let githubBaseURL = "GITHUB_BASE_URL"
    }
    
    var token: String {
        Configuration.value(for: Keys.githubToken)
    }
    
    var baseURL: String {
        Configuration.value(for: Paths.githubBaseURL)
    }
}
