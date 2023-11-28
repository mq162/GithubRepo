//
//  MockRepositoriesAPIServiceSuccess.swift
//  GihubRepoTests
//
//  Created by Braly Admin on 28/11/2023.
//

import Foundation
import Networking

struct MockRepositoriesAPIServiceSuccess: RepositoriesAPIServiceProtocol {

    func getRepos(page: Int, perPage: Int,
                  sort: Sort, type: SearchType,
                  direction: OrderType) async -> Result<[Repository], APIError> {
        let res = try! JSONFileMapper.decode(file: "Repositories", type: [Repository].self)

        return .success(res)
    }
}
