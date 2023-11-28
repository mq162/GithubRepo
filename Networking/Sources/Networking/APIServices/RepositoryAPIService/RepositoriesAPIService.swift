//
//  RepositoriesAPIService.swift
//  GihubRepo
//
//  Created by Quang on 25/11/2023.
//

import Foundation

public protocol RepositoriesAPIServiceProtocol {
    func getRepos(page: Int, perPage: Int,
                  sort: Sort, type: SearchType,
                  direction: OrderType) async -> Result<[Repository], APIError>
}

public struct RepositoriesAPIService {
    private let apiService: APIServiceProtocol
    private let apiConfig: APIConfigProtocol

    public init(apiService: APIServiceProtocol, apiConfig: APIConfigProtocol) {
        self.apiService = apiService
        self.apiConfig = apiConfig
    }
}

extension RepositoriesAPIService: RepositoriesAPIServiceProtocol {
    
    public func getRepos(page: Int, perPage: Int, sort: Sort,
                         type: SearchType, direction: OrderType) async -> Result<[Repository], APIError> {
        let request = GetRepositoriesAPI(page: page,
                                         perPage: perPage,
                                         sort: sort,
                                         type: type,
                                         direction: direction,
                                         config: apiConfig)
        return await apiService.send(request: request)
    }

}
