//
//  Repository.swift
//  GihubRepo
//
//  Created by Quang on 26/11/2023.
//

import Foundation

public struct Repository: Codable, Equatable {

    public let id: Int
    public let name: String
    public let description: String?
    
    public init(id: Int, name: String, description: String?) {
        self.id = id
        self.name = name
        self.description = description
    }
}
