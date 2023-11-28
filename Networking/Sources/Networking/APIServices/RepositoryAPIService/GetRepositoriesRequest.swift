//
//  GetRepositoriesRequest.swift
//  GihubRepo
//
//  Created by Quang on 26/11/2023.
//

import Foundation

public struct GetRepositoriesRequest: BaseRequestModel {
    let page: Int
    let perPage: Int
    let sort: Sort
    let type: SearchType
    let direction: OrderType
    
    public init(page: Int, perPage: Int, sort: Sort, type: SearchType, direction: OrderType) {
        self.page = page
        self.perPage = perPage
        self.sort = sort
        self.type = type
        self.direction = direction
    }
}

public enum Sort: String, Encodable {
    case created
    case updated
    case pushed
    case fullName
}

public enum SearchType: String, Encodable {
  case all
  case owner
  case member
}

public enum OrderType: String, Encodable {
  case desc
  case asc
}
