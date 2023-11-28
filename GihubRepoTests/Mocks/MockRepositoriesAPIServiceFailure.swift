//
//  MockRepositoriesAPIServiceFailure.swift
//  GihubRepoTests
//
//  Created by Braly Admin on 28/11/2023.
//

import Foundation
import Networking

struct MockRepositoriesAPIServiceFailure: RepositoriesAPIServiceProtocol {

    func getRepos(page: Int, perPage: Int,
                  sort: Sort, type: SearchType,
                  direction: OrderType) async -> Result<[Repository], APIError> {
        return .failure(.invalidResponse)
    }
}
